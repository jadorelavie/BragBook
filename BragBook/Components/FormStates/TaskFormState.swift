//
//  TaskFormState.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/7/25.
//

import Foundation
import SwiftUI

class TaskFormState: ObservableObject {
    @Published var taskTitle: String = ""
    @Published var taskDescription: String = ""
    @Published var tags: String = ""
    @Published var status: TaskStatus = .planned

    var isValid: Bool {
        !taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func populate(from task: Task) {
        taskTitle = task.taskTitle
        taskDescription = task.taskDescription
        tags = (task.tags ?? []).joined(separator: ", ")
        status = task.status
    }

    func reset() {
        taskTitle = ""
        taskDescription = ""
        tags = ""
        status = .planned
    }
}
