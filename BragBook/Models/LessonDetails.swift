import Foundation

struct LessonDetails: Identifiable, Codable {
    var id: UUID // same as outcomeID
    var outcomeID: UUID
    var reflectionText: String?
    var actionPlan: String?
    var skillImpacted: String?
    var createdAt: Date
    var updatedAt: Date
}