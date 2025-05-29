//
//  Accomplishment.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/28/25.
//


import Foundation

struct Accomplishment: FeedDisplayable {
    let id: UUID
    var journalEntryID: UUID // Foreign key to JournalEntry
    var impact: Int?        // Optional, 1-5 rating
    var outcome: String?    // Optional, long text
    var reviewDate: Date?   // Optional
    let creationDate: Date  // Non-optional, for sorting/display

    // Conformance to FeedDisplayable
    var date: Date { creationDate } // Use creationDate as the primary date for feed sorting
    var itemType: FeedItemType { .accomplishment }

    // Initializer
    init(id: UUID = UUID(), journalEntryID: UUID, impact: Int? = nil, outcome: String? = nil, reviewDate: Date? = nil, creationDate: Date = Date()) {
        self.id = id
        self.journalEntryID = journalEntryID
        self.impact = impact
        self.outcome = outcome
        self.reviewDate = reviewDate
        self.creationDate = creationDate
    }
}
