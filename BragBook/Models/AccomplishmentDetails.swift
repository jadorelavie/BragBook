import Foundation

struct AccomplishmentDetails: Identifiable, Codable {
    var id: UUID // same as outcomeID
    var outcomeID: UUID
    var impactRating: Int?
    var skillsInvolved: [String]?
    var resumeVisibility: Bool
    var createdAt: Date
    var updatedAt: Date
}