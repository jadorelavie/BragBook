//
//  AddItemView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 3/17/25.
//
import SwiftUI
import SwiftData

struct AddOutcomeView: View {
    @StateObject private var formState = OutcomeFormState()
    
    var onSave: (Outcome) -> Void
    var onCancel: () -> Void
    
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
            
            
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .environment(\.font, Font.custom("Futura-Regular", size: 14, relativeTo: .body))
            .navigationTitle("Why The Party?")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newOutcome = Outcome(
                            title: formState.title,
                            accomplishmentDate: formState.accomplishmentDate,
                            details: formState.details,
                            tags: formState.tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) },
                            impact: formState.impact,
                            reviewDate: formState.reviewDate, outcome: formState.outcome
                        )
                        onSave(newOutcome)
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
            }
        }
    }
}

struct AddOutcomeView_Previews: PreviewProvider {
    static var previews: some View {
        AddOutcomeView(onSave: { _ in }, onCancel: {})
    }
}
