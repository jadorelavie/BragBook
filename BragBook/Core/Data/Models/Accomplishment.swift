// Accomplishment.swift
// Stub file for BragBook starter project.

import Foundation
import SwiftData

@Model
final class Accomplishment {
    var id: UUID
    var title: String
    var descriptionText: String // Using descriptionText to avoid conflict with NSObject.description
    var dateAchieved: Date
    var impact: String // e.g., "High", "Medium", "Low" or a custom metric
    // Consider adding supporting documents, skills involved, etc. later

    init(id: UUID = UUID(), title: String = "", descriptionText: String = "", dateAchieved: Date = Date(), impact: String = "") {
        self.id = id
        self.title = title
        self.descriptionText = descriptionText
        self.dateAchieved = dateAchieved
        self.impact = impact
    }
}
