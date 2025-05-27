//
//  TaskSession.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/12/25.
//

import Foundation

struct TaskSession: Identifiable, Codable, Equatable {
    let id: UUID
    var taskID: UUID
    var startTime: Date
    var endTime: Date?
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        taskID: UUID,
        startTime: Date = Date(),
        endTime: Date? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.taskID = taskID
        self.startTime = startTime
        self.endTime = endTime
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    var duration: TimeInterval? {
        guard let end = endTime else { return nil }
        return end.timeIntervalSince(startTime)
    }
}
