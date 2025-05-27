import Foundation

struct Job: Identifiable, Codable {
    var id: UUID
    var userID: UUID
    var jobTitle: String
    var companyName: String
    var startDate: Date
    var endDate: Date?
    var description: String?
    var skillsRequired: [String]?
    var createdAt: Date
    var updatedAt: Date
}