//
//  EditAccomplishmentView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//


import SwiftUI
import SwiftData

struct EditAccomplishmentView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var accomplishment: Accomplishment
    let impactLevels = ["High", "Medium", "Low", "Unknown"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: .title)
                DatePicker("Date Achieved", selection: .dateAchieved, displayedComponents: .date)
                Section("Description") { TextEditor(text: .descriptionText).frame(minHeight: 150) }
                Section("Impact") {
                    Picker("Impact Level", selection: .impact) {
                        ForEach(impactLevels, id: \.self) { level in Text(level).tag(level) }
                    }
                }
            }
            .navigationTitle(accomplishment.title.isEmpty && accomplishment.descriptionText.isEmpty ? "New Accomplishment" : "Edit Accomplishment")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .navigationBarTrailing) { Button("Save") { dismiss() } }
            }
        }
    }
}
