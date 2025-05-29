import SwiftUI
import Foundation

struct JournalEntry: Identifiable, Codable, FeedDisplayable {
    let id: UUID
    var title: String
    var text: String
    var date: Date
    
    init(id: UUID = UUID(), title: String, text: String, date: Date) {
        self.id = id
        self.title = title
        self.text = text
        self.date = date
    }
}

extension JournalEntry {
    // MARK: - FeedDisplayable Conformance
    var itemType: FeedItemType {
        .journalEntry
    }
}
