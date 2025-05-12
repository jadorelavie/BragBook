import SwiftUI
import SwiftData

struct EditOutcomeView: View {
    @Bindable var outcome: Outcome
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @StateObject private var formState = OutcomeFormState()
    
    var body: some View {
        NavigationStack {
            OutcomeFormFieldsView(
                title: $formState.title,
                accomplishmentDate: $formState.accomplishmentDate,
                details: $formState.details,
                tags: $formState.tags,
                impact: $formState.impact,
                outcome: $formState.outcome,
                reviewDate: $formState.reviewDate
            )
            .navigationTitle("Edit Outcome")
            .onAppear {
                formState.title = outcome.title
                formState.accomplishmentDate = outcome.accomplishmentDate
                formState.details = outcome.details
                formState.tags = outcome.tags.joined(separator: ", ")
                formState.outcome = outcome.outcome ?? ""
                formState.impact = outcome.impact
                formState.reviewDate = outcome.reviewDate
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        outcome.title = formState.title
                        outcome.details = formState.details
                        outcome.tags = formState.tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                        outcome.outcome = formState.outcome
                        outcome.accomplishmentDate = formState.accomplishmentDate
                        outcome.impact = formState.impact
                        outcome.reviewDate = formState.reviewDate
                        
                        do {
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("Error saving changes: \(error.localizedDescription)")
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    let previewOutcome = Outcome(
        title: "Sample Outcome",
        accomplishmentDate: Date(),
        details: "Completed a major project milestone.",
        tags: ["SwiftUI", "Migration", "Testing"],
        impact: 4,
        reviewDate: Calendar.current.date(byAdding: .day, value: 30, to: Date()), outcome: "Success"
    )
    EditOutcomeView(outcome: previewOutcome)
}
