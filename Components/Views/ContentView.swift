import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel: FeedViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingAddEntrySheet = false
    @State private var entryToEdit: JournalEntry? // Added for editing

    var body: some View {
        NavigationView {
            List {
                if viewModel.items.isEmpty {
                    Text("No entries yet. Tap the '+' button to add one.")
                } else {
                    ForEach(viewModel.items) { feedItem in
                        switch feedItem.item.itemType {
                        case .journalEntry:
                            let journal = feedItem.item as! JournalEntry
                            NavigationLink(
                                destination: AddEditJournalEntryView(
                                    viewModel: viewModel.makeJournalVM(for: journal),
                                    entryToEdit: journal
                                )
                            ) {
                                VStack(alignment: .leading) {
                                    Text(journal.title).font(.headline)
                                    Text(journal.date, style: .date).font(.subheadline)
                                }
                            }

                        case .task:
                            // Placeholder row for Task items until Task support is implemented
                            Text("Task placeholder")

                        // Add more cases for other FeedItemType values as needed
                        default:
                            EmptyView()
                        }
                    }
                    .onDelete(perform: viewModel.deleteItem(at:))
                }
            }
            .navigationTitle("BragBook")
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
        ContentView(viewModel: FeedViewModel(context: PersistenceController.preview.container.viewContext))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
