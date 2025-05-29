//
//  FeedViewModel.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/28/25.
//


import SwiftUI
import Combine
import CoreData

class FeedViewModel: ObservableObject {
    // MARK: - Published Feed
    @Published var items: [FeedItem] = []
    
    // MARK: - Private Core Data Context
    private let viewContext: NSManagedObjectContext

    // MARK: - Initializers
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        loadFeedItems()
    }
    
    // Convenience init for App and Previews
    convenience init() {
        self.init(context: PersistenceController.shared.container.viewContext)
    }
    
    // MARK: - Load / Refresh
    private func loadFeedItems() {
        let fetchRequest: NSFetchRequest<JournalEntryEntity> = JournalEntryEntity.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \JournalEntryEntity.timestamp, ascending: false)
        ]
        do {
            let entities = try viewContext.fetch(fetchRequest)
            // Map to your domain model + wrap as FeedItem
            self.items = entities.map { entity in
                let model = JournalEntry(
                    id: entity.id ?? UUID(),
                    title: entity.title ?? "",
                    text: entity.text ?? "",
                    date: entity.timestamp ?? Date()
                )
                return FeedItem(item: model)
            }
        } catch {
            print("❌ Failed to fetch journal entries: \(error)")
            self.items = []
        }
    }
    
    // MARK: - Deletion
    /// Called by SwiftUI List onDelete
    func deleteItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let feedItem = items[index]
            guard feedItem.item.itemType == FeedItemType.journalEntry,
                  let journalEntry = feedItem.item as? JournalEntry else {
                return
            }
            // Fetch the matching Core Data entity
            let fetchRequest: NSFetchRequest<JournalEntryEntity> = JournalEntryEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", journalEntry.id as CVarArg)
            if let entityToDelete = (try? viewContext.fetch(fetchRequest))?.first {
                viewContext.delete(entityToDelete)
                do {
                    try viewContext.save()
                } catch {
                    viewContext.rollback()
                    print("❌ Failed to delete journal entry: \(error)")
                }
            }
        }
        // Refresh the feed
        loadFeedItems()
    }

    // In future, add other methods for creating feed items (tasks, accomplishments, etc.)
}
