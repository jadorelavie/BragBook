//
//  FeedItemType.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/18/25.
//

import Foundation

// Used to determine which sheet to present or which type to create
enum FeedItemType: String, CaseIterable, Identifiable {
    case entry
    case outcome
    case task

    var id: String { rawValue }

    var label: String {
        switch self {
        case .entry: return "Journal"
        case .outcome: return "Outcome"
        case .task: return "Task"
        }
    }

    var iconName: String {
        switch self {
        case .entry: return "book"
        case .outcome: return "sparkles"
        case .task: return "checkmark.circle"
        }
    }
}
