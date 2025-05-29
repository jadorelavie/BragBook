//
//  FeedItemType.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/28/25.
//
import Foundation

enum FeedItemType {
    case journalEntry
    case accomplishment // Added new case
    // Add other types here in the future, e.g., photoPost, milestone, etc.
}

protocol FeedDisplayable {
    var id: UUID { get }
    var date: Date { get } // Represents the primary date for sorting/display in the feed
    var itemType: FeedItemType { get }
}

struct FeedItem: Identifiable {
    let id: UUID
    let item: FeedDisplayable // The actual content (e.g., a JournalEntry)
    var type: FeedItemType { item.itemType } // Convenience accessor
    var date: Date { item.date } // Convenience accessor for sorting

    init(item: FeedDisplayable) {
        self.id = item.id // Use the item's ID for the FeedItem's ID
        self.item = item
    }
}
