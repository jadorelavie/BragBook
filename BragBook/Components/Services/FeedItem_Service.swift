//
//  FeedItem_Service.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/17/25.
//

import Foundation
import SwiftData


// Struct to carry form data
struct FeedItemData {
    var title: String
    var content: String?
    var date: Date?
    var impact: Int?
    var tags: [String]
    var status: TaskStatus?
}

// Service for centralized CRUD logic
final class FeedItemService {

    // MARK: - Create
    func createFeedItem(ofType type: FeedItemType, with data: FeedItemData, context: ModelContext) {
        switch type {
        case .entry:
            let newEntry = Entry(
                entryID: UUID(),
                userID: UUID(), // TODO: Inject or access actual user
                title: data.title,
                content: data.content ?? "",
                entryDate: data.date ?? Date(),
                entryType: .reflection,
                jobID: nil
            )
            context.insert(newEntry)

        case .outcome:
            let newOutcome = Outcome(
                outcomeID: UUID(),
                entryID: UUID(), // Will need adjustment if linked to entry
                title: data.title,
                accomplishmentDate: data.date ?? Date(),
                details: data.content ?? "",
                reviewDate: nil,
                type: .notSet, // Placeholder; adjust as needed
                jobID: nil as UUID?
            )
            context.insert(newOutcome)

        case .task:
            let newTask = Task(
                taskID: UUID(),
                entryID: nil,
                accomplishmentID: nil,
                taskTitle: data.title,
                taskDescription: data.content ?? "",
                status: data.status ?? .planned,
                jobID: nil
            )
            context.insert(newTask)
        }
    }

    // MARK: - Update
    func updateFeedItem(_ item: Any, with data: FeedItemData, context: ModelContext) {
        if let entry = item as? Entry {
            entry.title = data.title
            entry.content = data.content ?? entry.content
            entry.entryDate = data.date ?? entry.entryDate

        } else if let outcome = item as? Outcome {
            outcome.title = data.title
            outcome.details = data.content ?? outcome.details
            outcome.accomplishmentDate = data.date ?? outcome.accomplishmentDate

        } else if let task = item as? Task {
            task.taskTitle = data.title
            task.taskDescription = data.content ?? task.taskDescription
            task.status = data.status ?? task.status
        }
        // context is automatically tracking; no need to explicitly save
    }

    // MARK: - Delete
    func deleteFeedItem(_ item: Any, context: ModelContext) {
        if let entry = item as? Entry {
            context.delete(entry)
        } else if let outcome = item as? Outcome {
            context.delete(outcome)
        } else if let task = item as? Task {
            context.delete(task)
        }
    }
}
