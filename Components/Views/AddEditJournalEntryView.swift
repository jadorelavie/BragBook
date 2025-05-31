import SwiftUI

struct AddEditJournalEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: JournalViewModel
    
    @State private var title: String = ""
    @State private var text: String = ""
    @State private var date: Date = Date()
    
    var entryToEdit: JournalEntry?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Entry Details")) {
                    TextField("Title", text: $title)
                    
                    // TextEditor does not have a direct placeholder.
                    // We can use a ZStack to overlay a Text view as a placeholder.
                    ZStack(alignment: .topLeading) {
                        if text.isEmpty {
                            Text("Enter your thoughts here...")
                                .foregroundColor(Color(UIColor.placeholderText))
                                .padding(.top, 8) // Approximate padding to match TextEditor's internal padding
                                .padding(.leading, 5)
                        }
                        TextEditor(text: $text)
                            .frame(minHeight: 150) // Give it some initial height
                    }
                    
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle(entryToEdit == nil ? "Add Entry" : "Edit Entry")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    if let entry = entryToEdit {
                        // Build a new JournalEntry struct with updated fields but same id
                        let updatedEntry = JournalEntry(id: entry.id, title: title, text: text, date: date)
                        viewModel.updateEntry(updatedEntry)
                    } else {
                        viewModel.addEntry(title: title, text: text, date: date)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .onAppear {
                if let entry = entryToEdit {
                    title = entry.title
                    text = entry.text
                    date = entry.date
                }
            }
        }
    }
}

struct AddEditJournalEntryView_Previews: PreviewProvider {
    static var previews: some View {
        // For adding a new entry
        AddEditJournalEntryView(viewModel: JournalViewModel(context: PersistenceController.preview.container.viewContext))
        
        // For editing an existing entry
        // Creating a dummy JournalEntry for preview purposes.
        // Note: In a real app, JournalEntry might have more complex initialization or be a class.
        // For this struct, direct memberwise initialization is fine.
        AddEditJournalEntryView(viewModel: JournalViewModel(context: PersistenceController.preview.container.viewContext), entryToEdit: JournalEntry(id: UUID(), title: "Sample Title", text: "This is some sample text for the journal entry.", date: Date()))
    }
}
