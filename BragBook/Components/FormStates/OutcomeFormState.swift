//
//  OutcomeFormState.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/7/25.
//

import Foundation
import SwiftUI

class OutcomeFormState: ObservableObject {
    @Published var title: String = ""
    @Published var accomplishmentDate: Date = Date()
    @Published var details: String = ""
    @Published var tags: String = ""
    @Published var outcome: String = ""
    @Published var impact: Int? = nil
    @Published var reviewDate: Date? = nil

    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func populate(from outcome: Outcome) {
        title = outcome.title
        accomplishmentDate = outcome.accomplishmentDate
        details = outcome.details
        tags = outcome.tags.joined(separator: ", ")
        impact = outcome.impact
        reviewDate = outcome.reviewDate
        self.outcome = outcome.type.rawValue
    }

    func reset() {
        title = ""
        accomplishmentDate = Date()
        details = ""
        tags = ""
        impact = nil
        reviewDate = nil
        outcome = ""
    }
}
