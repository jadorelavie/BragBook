import Foundation
import SwiftData

@MainActor
class EntryDataService {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAllEntries() async throws -> [Entry] {
        let descriptor = FetchDescriptor<Entry>(
            sortBy: [SortDescriptor(\Entry.entryDate, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }
}
