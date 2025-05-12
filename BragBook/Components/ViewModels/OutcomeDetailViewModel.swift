//
//  OutcomeDetailViewModel.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/7/25.
//
import Foundation
import SwiftUI

class OutcomeDetailViewModel: ObservableObject {
    let outcome: Outcome
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: outcome.accomplishmentDate)
    }

    var impactDescriptionText: String {
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

    init(outcome: Outcome) {
        self.outcome = outcome
    }
}

