//
//  Outcome.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 3/10/25.
//

import Foundation
import SwiftData

@Model
class Outcome {
    var creationDate: Date = Date() // Default to current date
    var title: String = "Untitled" // Default title
    var details: String = "" // Default empty string
    var tags: [String] = [] // Default empty array

    // New fields
    var impact: Int? = nil // Optional impact rating (0-5)
    var reviewDate: Date? = nil // Optional review date
    var accomplishmentDate: Date = Date()
    var outcome: String? = nil

    init(creationDate: Date = Date(),
         title: String = "Untitled",
         accomplishmentDate: Date = Date(),
         details: String = "",
         tags: [String] = [],
         impact: Int? = nil,
         reviewDate: Date? = nil,

         outcome: String? = nil) {
        self.creationDate = creationDate
        self.title = title
        self.details = details
        self.tags = tags
        self.impact = impact
        self.reviewDate = reviewDate
        self.accomplishmentDate = accomplishmentDate
        self.outcome = outcome
    }
}
