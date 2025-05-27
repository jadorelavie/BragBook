//
//  EditLessonLearnedView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//


import SwiftUI
import SwiftData

struct EditLessonLearnedView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var lessonLearned: LessonLearned

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: .title)
                DatePicker("Date Learned", selection: .dateLearned, displayedComponents: .date)
                Section("Situation") { TextEditor(text: .situation).frame(minHeight: 100) }
                Section("Lesson") { TextEditor(text: .lesson).frame(minHeight: 100) }
                Section("Outcome") { TextEditor(text: .outcome).frame(minHeight: 100) }
            }
            .navigationTitle(lessonLearned.title.isEmpty && lessonLearned.lesson.isEmpty ? "New Lesson" : "Edit Lesson")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .navigationBarTrailing) { Button("Save") { dismiss() } }
            }
        }
    }
}
