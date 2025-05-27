
// JoinTables.swift
// BragBook
// Auto-generated: Join models for normalized tags and skills

import Foundation

// MARK: - Tag Joins

struct EntryTag: Identifiable, Codable, Equatable {
    var entryID: UUID
    var tagID: UUID
    var id: String { "\(entryID.uuidString)_\(tagID.uuidString)" }
}

struct TaskTag: Identifiable, Codable, Equatable {
    var taskID: UUID
    var tagID: UUID
    var id: String { "\(taskID.uuidString)_\(tagID.uuidString)" }
}

struct OutcomeTag: Identifiable, Codable, Equatable {
    var outcomeID: UUID
    var tagID: UUID
    var id: String { "\(outcomeID.uuidString)_\(tagID.uuidString)" }
}

// MARK: - Skill Joins

struct EntrySkill: Identifiable, Codable, Equatable {
    var entryID: UUID
    var skillID: UUID
    var id: String { "\(entryID.uuidString)_\(skillID.uuidString)" }
}

struct TaskSkill: Identifiable, Codable, Equatable {
    var taskID: UUID
    var skillID: UUID
    var id: String { "\(taskID.uuidString)_\(skillID.uuidString)" }
}

struct OutcomeSkill: Identifiable, Codable, Equatable {
    var outcomeID: UUID
    var skillID: UUID
    var id: String { "\(outcomeID.uuidString)_\(skillID.uuidString)" }
}

struct JobSkill: Identifiable, Codable, Equatable {
    var jobID: UUID
    var skillID: UUID
    var id: String { "\(jobID.uuidString)_\(skillID.uuidString)" }
}

// MARK: - Task/Session Join

struct TaskTaskSession: Identifiable, Codable, Equatable {
    var taskID: UUID
    var sessionID: UUID
    var id: String { "\(taskID.uuidString)_\(sessionID.uuidString)" }
}
