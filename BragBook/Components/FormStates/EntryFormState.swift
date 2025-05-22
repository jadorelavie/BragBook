//
//  EntryFormState.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/7/25.
//

import Foundation
import SwiftUI

class EntryFormState: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var entryDate: Date = Date()
    @Published var tags: String = ""

    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func populate(from entry: Entry) {
        title = entry.title
        content = entry.content
        entryDate = entry.entryDate
        tags = entry.tags.joined(separator: ", ")
    }

    func reset() {
        title = ""
        content = ""
        entryDate = Date()
        tags = ""
    }
}
