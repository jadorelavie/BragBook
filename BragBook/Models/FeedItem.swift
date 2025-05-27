//
//  FeedItem.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/16/25.
//
import Foundation

enum FeedItem: Identifiable {
    case outcome(Outcome)
    case entry(Entry)
    case task(Task)

    var id: UUID {
        switch self {
        case .outcome(let outcome):
            return outcome.outcomeID
        case .entry(let entry):
            return entry.entryID
        case .task(let task):
            return task.taskID
        }
    }

    var feedDate: Date {
        switch self {
        case .outcome(let outcome):
            return outcome.accomplishmentDate
        case .entry(let entry):
            return entry.entryDate
        case .task(let task):
            return task.createdAt
        }
    }

    var iconName: String {
        switch self {
        case .entry: return "book"
        case .outcome: return "sparkles"
        case .task: return "checkmark.circle"
        }
    }

    var label: String {
        switch self {
        case .outcome(let outcome):
            return outcome.type.rawValue
        case .entry:
            return "Journal"
        case .task:
            return "Task"
        }
    }

    var type: FeedItemType {
        switch self {
        case .entry: return .entry
        case .outcome: return .outcome
        case .task: return .task
        }
    }
}
