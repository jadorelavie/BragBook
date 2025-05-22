//
//  Outcome.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 3/10/25.
//

import Foundation
import SwiftData

// OutcomeType enum used as a validation flag to indicate the state of the outcome
enum OutcomeType: String, Codable {
    case accomplishment
    case lesson
    case notSet
}

@Model
class Outcome {
    var outcomeID: UUID = UUID()
    var entryID: UUID = UUID()
    var creationDate: Date = Date()
    var title: String = "Untitled"
    var details: String = ""
    var tags: [String] = []
    var impact: Int? = nil
    var reviewDate: Date? = nil
    var accomplishmentDate: Date = Date()
    var outcome: String? = nil
    // Type property used as a validation flag
    var type: OutcomeType = OutcomeType.notSet
    var jobID: UUID? = nil
    

    init(outcomeID: UUID = UUID(),
         entryID: UUID = UUID(),
         creationDate: Date = Date(),
         title: String = "Untitled",
         accomplishmentDate: Date = Date(),
         details: String = "",
         tags: [String] = [],
         impact: Int? = nil,
         reviewDate: Date? = nil,
         outcome: String? = nil,
         type: OutcomeType = .notSet,
         jobID: UUID? = nil) {
        self.outcomeID = outcomeID
        self.entryID = entryID
        self.creationDate = creationDate
        self.title = title
        self.details = details
        self.tags = tags
        self.impact = impact
        self.reviewDate = reviewDate
        self.accomplishmentDate = accomplishmentDate
        self.outcome = outcome
        self.type = type
        self.jobID = jobID
    }
}
