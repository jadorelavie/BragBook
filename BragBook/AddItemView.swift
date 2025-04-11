//
//  AddItemView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 3/17/25.
//
import SwiftUI
import SwiftData

struct AddItemView: View {
    @Binding var newTitle: String
    @Binding var newDetails: String
    @Binding var newOutcome: String
    @Binding var newTags: String
    @Binding var newImpact: Int?  // Optional Impact value (0–5)
    @Binding var newReviewDate: Date?
    @Binding var newAccomplishmentDate: Date
    
    var onSave: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information") {
                    TextField("Title", text: $newTitle)
                    TextField("Details", text: $newDetails, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                }
                
                Section("Accomplishment") {
                    DatePicker("Date", selection: $newAccomplishmentDate, displayedComponents: .date)
                    Picker("Impact", selection: Binding<Int>(
                        get: { newImpact ?? -1 },
                        set: { newImpact = $0 == -1 ? nil : $0 }
                    )) {
                        Text("TBD").tag(-1)
                        Text("0 – Negative").tag(0)
                        Text("1 – Individual").tag(1)
                        Text("2 – Team").tag(2)
                        Text("3 – Department").tag(3)
                        Text("4 – Organization").tag(4)
                        Text("5 – Beyond Organization").tag(5)
                    }
                    .pickerStyle(MenuPickerStyle())
                    TextField("Outcome", text: $newOutcome, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                    DatePicker("Review Date", selection: Binding<Date>(
                        get: { newReviewDate ?? Date() },
                        set: { newReviewDate = $0 }
                    ), displayedComponents: .date)
                    
                    Button("Clear Review Date") {
                        newReviewDate = nil
                    }
                    .foregroundColor(.red)
                }
                
                Section("Tags") {
                    TextField("Tags (comma-separated)", text: $newTags)
                }
                
            }
            
            
            
            .navigationTitle("Why The Celebration?")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: onSave)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(newTitle: .constant("Test Title"),
                    newDetails: .constant("Test Details"),
                    newOutcome: .constant("Test Outcome"),
                    newTags: .constant("Tag1, Tag2"),
                    newImpact: .constant(nil),
                    newReviewDate: .constant(nil),
                    newAccomplishmentDate: .constant(Date()),
                    onSave: {},
                    onCancel: {})
    }
}
