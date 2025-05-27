//
//  AddEditTaskSheet.swift
//  BragBook
//
//  Created by BragBook Team on 5/17/25.
//

import SwiftUI
import SwiftData

struct AddEditTaskSheet: View {
    @ObservedObject var formState: TaskFormState
    var isEditing: Bool = false
    var onSave: () -> Void
    var onCancel: () -> Void

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Task Title", text: $formState.taskTitle)
                TextEditor(text: $formState.taskDescription)
                    .frame(height: 120)
                TextField("Tags (comma-separated)", text: $formState.tags)
                Picker("Status", selection: $formState.status) {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        Text(status.rawValue.capitalized).tag(status)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            .navigationTitle(isEditing ? "Edit Task" : "New Task")
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
