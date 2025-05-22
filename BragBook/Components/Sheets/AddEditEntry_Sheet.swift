//
//  AddEditEntrySheet.swift
//  BragBook
//
//  Created by BragBook Team on 5/17/25.
//

import SwiftUI
import SwiftData

struct AddEditEntrySheet: View {
    @ObservedObject var formState: EntryFormState
    var isEditing: Bool = false
    var onSave: () -> Void
    var onCancel: () -> Void

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $formState.title)
                TextEditor(text: $formState.content)
                    .frame(height: 120)
                TextField("Tags (comma-separated)", text: $formState.tags)
                DatePicker("Date", selection: $formState.entryDate, displayedComponents: .date)
            }
            .padding()
            .navigationTitle(isEditing ? "Edit Entry" : "New Entry")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave()
                    }.disabled(!formState.isValid)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onCancel()
                    }
                }
            }
        }
    }
}
