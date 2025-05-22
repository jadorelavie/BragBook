import Foundation
import SwiftData

@MainActor
class TaskDataService {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchTasks(forEntryID entryID: UUID) async throws -> [Task] {
        let predicate = #Predicate<Task> { $0.entryID == entryID }
        let descriptor = FetchDescriptor<Task>(predicate: predicate)
        return try self.context.fetch(descriptor)
    }

    func fetchOrphanTasks() async throws -> [Task] {
        let predicate = #Predicate<Task> { $0.entryID == nil }
        let descriptor = FetchDescriptor<Task>(predicate: predicate)
        return try self.context.fetch(descriptor)
    }

    func fetchAllTasks() async throws -> [Task] {
        let descriptor = FetchDescriptor<Task>(
            sortBy: [SortDescriptor(\Task.createdAt, order: .reverse)]
        )
        return try self.context.fetch(descriptor)
    }
}
