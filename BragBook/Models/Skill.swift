import Foundation

struct Skill: Identifiable, Codable {
    var id: UUID
    var skillName: String
    var category: String?
    var createdAt: Date
    var updatedAt: Date
}