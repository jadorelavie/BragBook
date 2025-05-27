//
//  EditJournalEntryView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//


import SwiftUI
import SwiftData

struct EditJournalEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Bindable var journalEntry: JournalEntry

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: .title)
                DatePicker("Date", selection: .date, displayedComponents: .date)
                Section("Text") {
                    TextEditor(text: .text)
                        .frame(minHeight: 200)
                }
            }
            .navigationTitle(journalEntry.title.isEmpty && journalEntry.text.isEmpty ? "New Journal Entry" : "Edit Journal Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .navigationBarTrailing) { Button("Save") { dismiss() } }
            }
        }
    }
}
