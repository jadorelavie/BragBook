import SwiftUI

struct JournalEntry: Identifiable, Codable {
    let id = UUID()
    var title: String
    var text: String
    var date: Date
}
