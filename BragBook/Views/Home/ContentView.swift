import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JournalViewModel()
    @Environment(\.managedObjectContext) private var viewContext // Added for preview
    @State private var showingAddEntrySheet = false
    @State private var entryToEdit: JournalEntry? // Added for editing

    var body: some View {
        NavigationView {
            List {
                if viewModel.entries.isEmpty {
                    Text("No entries yet. Tap the '+' button to add one.")
                } else {
                    ForEach(viewModel.entries) { entry in
                        NavigationLink(destination: AddEditJournalEntryView(viewModel: viewModel, entryToEdit: entry)) {
                            VStack(alignment: .leading) {
                                Text(entry.title).font(.headline)
                                Text(entry.date, style: .date).font(.subheadline) // Original was .subheadline, subtask example uses .caption. Keeping .subheadline for consistency with original.
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteEntry)
                }
            }
            .navigationTitle("My Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddEntrySheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddEntrySheet) {
                AddEditJournalEntryView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
