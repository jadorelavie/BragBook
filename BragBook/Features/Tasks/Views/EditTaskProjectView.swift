//
//  EditTaskProjectView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//


import SwiftUI
import SwiftData

struct EditTaskProjectView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var taskProject: TaskProject
    let statusOptions = ["Todo", "In Progress", "Completed", "On Hold"]
    let priorityOptions = [1, 2, 3, 4, 5]

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: .title)
                Section("Description") { TextEditor(text: .descriptionText).frame(minHeight: 100) }
                Picker("Status", selection: .status) {
                    ForEach(statusOptions, id: \.self) { status in Text(status).tag(status) }
                }
                Picker("Priority", selection: .priority) {
                    ForEach(priorityOptions, id: \.self) { value in Text("\(value)").tag(value) }
                }
                DatePicker("Deadline", selection: .deadlineBinding, displayedComponents: .date)
            }
            .navigationTitle(taskProject.title.isEmpty && taskProject.descriptionText.isEmpty ? "New Task/Project" : "Edit Task/Project")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .navigationBarTrailing) { Button("Save") { dismiss() } }
            }
        }
    }
}

extension TaskProject { 
    var deadlineBinding: Date {
        get { self.deadline ?? Date() }
        set { self.deadline = newValue }
    }
}
