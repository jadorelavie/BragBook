//
//  OutcomeDetailViewModel.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/7/25.
//
import Foundation
import SwiftUI

class FeedDetailViewModel: ObservableObject {
    let feedItem: FeedItem

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        switch feedItem {
        case .outcome(let outcome):
            return formatter.string(from: outcome.accomplishmentDate)
        case .entry(let entry):
            return formatter.string(from: entry.entryDate)
        case .task(let task):
            return formatter.string(from: task.createdAt)
        }
    }

    var impactDescriptionText: String {
        guard case .outcome(let outcome) = feedItem else { return "" }
        switch outcome.impact ?? -1 {
        case 0:
            return "This hurt; it didn't help."
        case 1:
            return "This made my life better."
        case 2:
            return "This made my team's life better."
        case 3:
            return "This made my department better."
        case 4:
            return "This made my organization better."
        case 5:
            return "The reach of this effort helps beyond my immediate organization."
        default:
            return "TBD"
        }
    }

    init(feedItem: FeedItem) {
        self.feedItem = feedItem
    }
}
