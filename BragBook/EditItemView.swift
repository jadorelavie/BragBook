import SwiftUI
import SwiftData

struct EditItemView: View {
    @Bindable var item: Item
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var editedTitle: String
    @State private var editedDetails: String
    @State private var editedTags: String
    @State private var editedAccomplishmentDate: Date
    @State private var editedOutcome: String
    @State private var editedImpact: Int?
    @State private var editedReviewDate: Date?
    
    init(item: Item) {
        self.item = item
        _editedTitle = State(initialValue: item.title)
        _editedDetails = State(initialValue: item.details)
        _editedTags = State(initialValue: item.tags.joined(separator: ", "))
        _editedAccomplishmentDate = State(initialValue: item.accomplishmentDate)
        _editedOutcome = State(initialValue: item.outcome ?? "")
        _editedImpact = State(initialValue: item.impact)
        _editedReviewDate = State(initialValue: item.reviewDate)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title and Details") {
                    TextField("Title", text: $editedTitle)
                    TextField("Details", text: $editedDetails, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                }
                
           
                Section("Accomplishment") {
                    DatePicker("Date", selection: $editedAccomplishmentDate, displayedComponents: .date)
                    Picker("Impact", selection: Binding<Int>(
                        get: { editedImpact ?? -1 },
                        set: { editedImpact = $0 == -1 ? nil : $0 }
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
                    TextField("Outcome", text: $editedOutcome, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                    DatePicker("Review Date", selection: Binding<Date>(
                        get: { editedReviewDate ?? Date() },
                        set: { editedReviewDate = $0 }
                    ), displayedComponents: .date)
                    
                    Button("Clear Review Date") {
                        editedReviewDate = nil
                    }
                    .foregroundColor(.red)
                }
                
                Section("Tags") {
                    TextField("Tags (comma-separated)", text: $editedTags)
                }
            }
            .navigationTitle("Edit Item")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveChanges()
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
    
    private func saveChanges() {
        item.title = editedTitle
        item.details = editedDetails
        item.impact = editedImpact
        item.outcome = editedOutcome
        item.reviewDate = editedReviewDate
        item.tags = editedTags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Error saving changes: \(error.localizedDescription)")
        }
    }
}
