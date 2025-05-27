//
//  LessonLearned.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//


import Foundation
import SwiftData

@Model
final class LessonLearned {
    var id: UUID
    var title: String
    var situation: String // What was the context?
    var lesson: String // What was learned?
    var outcome: String // What was the result of applying the lesson?
    var dateLearned: Date
    // Consider adding tags, categories, etc. later

    init(id: UUID = UUID(), title: String = "", situation: String = "", lesson: String = "", outcome: String = "", dateLearned: Date = Date()) {
        self.id = id
        self.title = title
        self.situation = situation
        self.lesson = lesson
        self.outcome = outcome
        self.dateLearned = dateLearned
    }
}
