//
//  Entry.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/11/25.
//
import Foundation
import SwiftData

@Model
class Entry: Identifiable, Codable, Equatable {
    enum EntryType: String, Codable, CaseIterable, Identifiable {
        case reflection = "Reflection"
        case projectLog = "Project Log"
        case dailyLog = "Daily Log"
        case freeWrite = "Free Write"

        var id: String { self.rawValue }
    }

    var entryID: UUID
    var userID: UUID
    var title: String
    var content: String
    var entryDate: Date
    var entryType: EntryType
    var jobID: UUID?
    var createdAt: Date
    var updatedAt: Date
    var tags: [String]

    var id: UUID { entryID }

    init(
        entryID: UUID = UUID(),
        userID: UUID,
        title: String = "",
        content: String = "",
        entryDate: Date = Date(),
        entryType: EntryType = .reflection,
        jobID: UUID? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        tags: [String] = []
    ) {
        self.entryID = entryID
        self.userID = userID
        self.title = title
        self.content = content
        self.entryDate = entryDate
        self.entryType = entryType
        self.jobID = jobID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.tags = tags
    }
    var feedItemType: String {
        return "journal"
    }

    enum CodingKeys: String, CodingKey {
        case entryID
        case userID
        case title
        case content
        case entryDate
        case entryType
        case jobID
        case createdAt
        case updatedAt
        case tags
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let entryID = try container.decode(UUID.self, forKey: .entryID)
        let userID = try container.decode(UUID.self, forKey: .userID)
        let title = try container.decode(String.self, forKey: .title)
        let content = try container.decode(String.self, forKey: .content)
        let entryDate = try container.decode(Date.self, forKey: .entryDate)
        let entryType = try container.decode(EntryType.self, forKey: .entryType)
        let jobID = try container.decodeIfPresent(UUID.self, forKey: .jobID)
        let createdAt = try container.decode(Date.self, forKey: .createdAt)
        let updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        let tags = try container.decode([String].self, forKey: .tags)
        self.init(
            entryID: entryID,
            userID: userID,
            title: title,
            content: content,
            entryDate: entryDate,
            entryType: entryType,
            jobID: jobID,
            createdAt: createdAt,
            updatedAt: updatedAt,
            tags: tags
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(entryID, forKey: .entryID)
        try container.encode(userID, forKey: .userID)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(entryDate, forKey: .entryDate)
        try container.encode(entryType, forKey: .entryType)
        try container.encodeIfPresent(jobID, forKey: .jobID)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(tags, forKey: .tags)
    }

    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.entryID == rhs.entryID &&
            lhs.userID == rhs.userID &&
            lhs.title == rhs.title &&
            lhs.content == rhs.content &&
            lhs.entryDate == rhs.entryDate &&
            lhs.entryType == rhs.entryType &&
            lhs.jobID == rhs.jobID &&
            lhs.createdAt == rhs.createdAt &&
            lhs.updatedAt == rhs.updatedAt &&
            lhs.tags == rhs.tags
    }
}
