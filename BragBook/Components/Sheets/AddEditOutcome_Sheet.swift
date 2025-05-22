//
//  AddOutcomeView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 3/17/25.
//
import SwiftUI
import SwiftData

struct AddEditOutcomeSheet: View {
    @ObservedObject var formState: OutcomeFormState
    var isEditing: Bool = false

    var onSave: () -> Void
    var onCancel: () -> Void

    var body: some View {
        NavigationStack {
            Detail_View()
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .environment(\.font, Font.custom("Futura-Regular", size: 14, relativeTo: .body))
            .navigationTitle(isEditing ? "Edit Outcome" : "Why The Party?")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave()
                    }
                    .disabled(!formState.isValid)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
            }
        }
    }
}

struct AddEditOutcomeSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddEditOutcomeSheet(formState: OutcomeFormState(), isEditing: false, onSave: {}, onCancel: {})
    }
}
