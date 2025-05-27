import SwiftUI
import Combine
import CoreData

class JournalViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []
    private var viewContext: NSManagedObjectContext // Changed for DI

    init(persistenceController: PersistenceController = .shared) { // Changed for DI
        self.viewContext = persistenceController.container.viewContext // Changed for DI
        fetchEntries()
    }

    // Renamed from private func fetchEntries() to public func fetchEntries() for testability
    // Or, if it should remain private, the testFetchEntries will need to re-initialize SUT
    // For now, let's assume it should be callable for the test as per subtask description.
    // However, the subtask description says "Call sut.fetchEntries() (or re-initialize sut to trigger fetch in its init)."
    // Re-initializing SUT is cleaner if fetchEntries is meant to be an internal detail of init.
    // Let's keep it private and have the test re-initialize SUT.
    private func fetchEntries() {
        let request = NSFetchRequest<JournalEntryEntity>(entityName: "JournalEntryEntity")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \JournalEntryEntity.timestamp, ascending: false)]

        do {
            let results = try viewContext.fetch(request)
            entries = results.map { entity -> JournalEntry in
                // Ensure default values if any optional Core Data attributes are nil,
                // though our schema defines them as non-optional.
                return JournalEntry(
                    id: entity.id ?? UUID(), // Should always have a UUID from Core Data
                    title: entity.title ?? "Untitled",
                    text: entity.text ?? "",
                    date: entity.timestamp ?? Date()
                )
            }
        } catch {
            print("Failed to fetch journal entries: \(error)")
        }
    }

    func addEntry(title: String, text: String, date: Date) {
        let newEntryEntity = JournalEntryEntity(context: viewContext)
        newEntryEntity.id = UUID() // Assign a new UUID
        newEntryEntity.title = title
        newEntryEntity.text = text
        newEntryEntity.timestamp = date
        
        saveContext()
        fetchEntries() // Refresh the @Published entries array
    }

    func updateEntry(_ entry: JournalEntry, title: String, text: String, date: Date) {
        let request = NSFetchRequest<JournalEntryEntity>(entityName: "JournalEntryEntity")
        request.predicate = NSPredicate(format: "id == %@", entry.id as CVarArg)
        
        do {
            let results = try viewContext.fetch(request)
            if let entityToUpdate = results.first {
                entityToUpdate.title = title
                entityToUpdate.text = text
                entityToUpdate.timestamp = date
                
                saveContext()
                fetchEntries() // Refresh
            } else {
                print("Failed to find entry with ID \(entry.id) to update.")
            }
        } catch {
            print("Failed to fetch entry for update: \(error)")
        }
    }

    func deleteEntry(at offsets: IndexSet) {
        let entriesToDelete = offsets.map { entries[$0] }
        
        for entry in entriesToDelete {
            let request = NSFetchRequest<JournalEntryEntity>(entityName: "JournalEntryEntity")
            request.predicate = NSPredicate(format: "id == %@", entry.id as CVarArg)
            
            do {
                let results = try viewContext.fetch(request)
                if let entityToDelete = results.first {
                    viewContext.delete(entityToDelete)
                } else {
                    print("Failed to find entry with ID \(entry.id) to delete.")
                }
            } catch {
                print("Failed to fetch entry for deletion: \(error)")
                // Optionally, decide if you want to stop or continue if one fails
            }
        }
        
        saveContext()
        fetchEntries() // Refresh
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
            // Consider more robust error handling for production apps
            // For example, presenting an alert to the user
        }
    }
}
