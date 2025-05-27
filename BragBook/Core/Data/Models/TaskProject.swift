//
//  TaskProject.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//


import Foundation
import SwiftData

@Model
final class TaskProject {
    var id: UUID
    var title: String
    var descriptionText: String
    var status: String // e.g., "Todo", "In Progress", "Completed", "On Hold"
    var priority: Int // e.g., 1 (High) to 5 (Low)
    var deadline: Date? // Optional deadline
    var dateCreated: Date
    // Consider adding subtasks, related projects, attachments later

    init(id: UUID = UUID(), title: String = "", descriptionText: String = "", status: String = "Todo", priority: Int = 3, deadline: Date? = nil, dateCreated: Date = Date()) {
        self.id = id
        self.title = title
        self.descriptionText = descriptionText
        self.status = status
        self.priority = priority
        self.deadline = deadline
        self.dateCreated = dateCreated
    }
}
