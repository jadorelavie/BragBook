



import Foundation
import SwiftData

@MainActor
class OutcomeDataService {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchOutcome(forEntryID entryID: UUID) throws -> Outcome? {
        let predicate = #Predicate<Outcome> { $0.entryID == entryID }
        let descriptor = FetchDescriptor<Outcome>(predicate: predicate)
        return try context.fetch(descriptor).first
    }

    func fetchAllOutcomes() async throws -> [Outcome] {
        let descriptor = FetchDescriptor<Outcome>(
            sortBy: [SortDescriptor(\Outcome.accomplishmentDate, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }
}
