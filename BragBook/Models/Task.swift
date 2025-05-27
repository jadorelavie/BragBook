import Foundation
import SwiftData

enum TaskStatus: String, CaseIterable, Codable {
    case planned
    case inProgress
    case completed
}

@Model
class Task: Identifiable, Codable {
    var taskID: UUID = UUID()
    var entryID: UUID? = nil
    var accomplishmentID: UUID? = nil
    var taskTitle: String = ""
    var taskDescription: String = ""
    var startTime: Date? = nil
    var endTime: Date? = nil
    var duration: TimeInterval? = nil
    @Attribute var status: TaskStatus
    var skillsUsed: [String]? = nil
    var jobID: UUID? = nil
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    

    var id: UUID { taskID }
    var tags: [String]? = nil

    // MARK: - Initializer required by @Model macro
    init(
        taskID: UUID = UUID(),
        entryID: UUID? = nil,
        accomplishmentID: UUID? = nil,
        taskTitle: String = "",
        taskDescription: String = "",
        startTime: Date? = nil,
        endTime: Date? = nil,
        duration: TimeInterval? = nil,
        status: TaskStatus = .planned,
        skillsUsed: [String]? = nil,
        jobID: UUID? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.taskID = taskID
        self.entryID = entryID
        self.accomplishmentID = accomplishmentID
        self.taskTitle = taskTitle
        self.taskDescription = taskDescription
        self.startTime = startTime
        self.endTime = endTime
        self.duration = duration
        self.status = status
        self.skillsUsed = skillsUsed
        self.jobID = jobID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    // MARK: - Codable conformance
    enum CodingKeys: String, CodingKey {
        case taskID
        case entryID
        case accomplishmentID
        case taskTitle
        case taskDescription
        case startTime
        case endTime
        case duration
        case status
        case skillsUsed
        case jobID
        case createdAt
        case updatedAt
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let taskID = try container.decode(UUID.self, forKey: .taskID)
        let entryID = try container.decodeIfPresent(UUID.self, forKey: .entryID)
        let accomplishmentID = try container.decodeIfPresent(UUID.self, forKey: .accomplishmentID)
        let taskTitle = try container.decode(String.self, forKey: .taskTitle)
        let taskDescription = try container.decode(String.self, forKey: .taskDescription)
        let startTime = try container.decodeIfPresent(Date.self, forKey: .startTime)
        let endTime = try container.decodeIfPresent(Date.self, forKey: .endTime)
        let duration = try container.decodeIfPresent(TimeInterval.self, forKey: .duration)
        let statusRaw = try container.decode(String.self, forKey: .status)
        let status = TaskStatus(rawValue: statusRaw) ?? .planned
        let skillsUsed = try container.decodeIfPresent([String].self, forKey: .skillsUsed)
        let jobID = try container.decodeIfPresent(UUID.self, forKey: .jobID)
        let createdAt = try container.decode(Date.self, forKey: .createdAt)
        let updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.init(
            taskID: taskID,
            entryID: entryID,
            accomplishmentID: accomplishmentID,
            taskTitle: taskTitle,
            taskDescription: taskDescription,
            startTime: startTime,
            endTime: endTime,
            duration: duration,
            status: status,
            skillsUsed: skillsUsed,
            jobID: jobID,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(taskID, forKey: .taskID)
        try container.encodeIfPresent(entryID, forKey: .entryID)
        try container.encodeIfPresent(accomplishmentID, forKey: .accomplishmentID)
        try container.encode(taskTitle, forKey: .taskTitle)
        try container.encode(taskDescription, forKey: .taskDescription)
        try container.encodeIfPresent(startTime, forKey: .startTime)
        try container.encodeIfPresent(endTime, forKey: .endTime)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encode(status.rawValue, forKey: .status)
        try container.encodeIfPresent(skillsUsed, forKey: .skillsUsed)
        try container.encodeIfPresent(jobID, forKey: .jobID)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}
