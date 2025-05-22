//  FeedViewModel.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/16/25.
//

import Foundation
import Combine
import SwiftData

@MainActor
class FeedViewModel: ObservableObject {
    // Optionally, for filtering:
    @Published var filter: String? = nil

    init() {
    }

    // MARK: - Load all items for unified feed
    @MainActor func loadFeedItems(context: ModelContext) async -> [FeedItem] {
        let entryService = EntryDataService(context: context)
        let outcomeService = OutcomeDataService(context: context)
        let taskService = TaskDataService(context: context)

        var items: [FeedItem] = []

        do {
            let entries = try await entryService.fetchAllEntries()
            items.append(contentsOf: entries.map { FeedItem.entry($0) })

            let outcomes = try await outcomeService.fetchAllOutcomes()
            items.append(contentsOf: outcomes.map { FeedItem.outcome($0) })

            let tasks = try await taskService.fetchAllTasks()
            items.append(contentsOf: tasks.map { FeedItem.task($0) })

            let sorted = items.sorted { $0.feedDate > $1.feedDate }
            return sorted

        } catch {
            print("Error fetching feed items: \(error)")
            return []
        }
    }

    // MARK: - Filtering (optional)
    func filteredFeedItems(from items: [FeedItem]) -> [FeedItem] {
        guard let filter = filter else { return items }
        return items.filter { $0.type.rawValue == filter }
    }
}
