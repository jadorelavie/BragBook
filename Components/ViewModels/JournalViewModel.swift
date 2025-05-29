import SwiftUI
import Combine
import CoreData

class JournalViewModel: ObservableObject {
    // MARK: - Public API
    @Published var entryToEdit: JournalEntry?

    // MARK: - Private
    private let viewContext: NSManagedObjectContext

    // Now we accept the context and an optional entry to edit
    init(context: NSManagedObjectContext, entryToEdit: JournalEntry? = nil) {
        self.viewContext = context
        self.entryToEdit = entryToEdit
    }
    
    // MARK: - Mutation Methods

    /// Create a new journal entry in Core Data
    func addEntry(title: String, text: String, date: Date) {
        let newEntity = JournalEntryEntity(context: viewContext)
        newEntity.id = UUID()
        newEntity.title = title
        newEntity.text = text
        newEntity.timestamp = date

        saveContext()
    }
    
    /// Update an existing journal entry
    func updateEntry(_ entry: JournalEntry) {
        let fetchRequest: NSFetchRequest<JournalEntryEntity> = JournalEntryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", entry.id as CVarArg)
        do {
            if let entity = try viewContext.fetch(fetchRequest).first {
                entity.title = entry.title
                entity.text = entry.text
                entity.timestamp = entry.date
                saveContext()
            }
        } catch {
            print("Update failed: \(error)")
        }
    }
    
    /// Delete a journal entry
    func deleteEntry(_ entry: JournalEntry) {
        let fetchRequest: NSFetchRequest<JournalEntryEntity> = JournalEntryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", entry.id as CVarArg)
        do {
            if let entity = try viewContext.fetch(fetchRequest).first {
                viewContext.delete(entity)
                saveContext()
            }
        } catch {
            print("Delete failed: \(error)")
        }
    }
    
    // MARK: - Private Helpers
    
    /// Save changes in the context if needed
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Save context failed: \(error)")
        }
    }
}
