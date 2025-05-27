//
//  JournalEntry.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//


import Foundation
import SwiftData

@Model
final class JournalEntry {
    var id: UUID
    var title: String
    var text: String
    var date: Date
    // Consider adding mood, tags, etc. later

    init(id: UUID = UUID(), title: String = "", text: String = "", date: Date = Date()) {
        self.id = id
        self.title = title
        self.text = text
        self.date = date
    }
}
