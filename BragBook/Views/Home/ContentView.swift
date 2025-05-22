// MARK: - Imports
import SwiftUI
import SwiftData


// MARK: - Toolbar

struct BragBookToolbar: ToolbarContent {
    let onAddEntry: () -> Void

    var body: some ToolbarContent {
        ToolbarItem {
            Button(action: { onAddEntry() }) {
                Label("Add Entry", systemImage: "plus")
            }
        }
    }
}

// MARK: - Main View

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
 /*   @State private var internalShowAddItemAlert = false
    private let externalShowAddItemAlert: Binding<Bool>?
    private var showAddItemAlert: Binding<Bool> {
        resolvedBinding(externalShowAddItemAlert, fallback: $internalShowAddItemAlert)
    } */
    
    // @StateObject private var vm = ContentViewModel()
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var preferredCompactColumn: NavigationSplitViewColumn = .sidebar
    
    // MARK: - Sheet State
    @StateObject private var entryFormState = EntryFormState()
    @StateObject private var outcomeFormState = OutcomeFormState()
    @StateObject private var taskFormState = TaskFormState()
    
    @State private var selectedType: FeedItemType? = nil
    
    @State private var feedItems: [FeedItem] = []

    // MARK: - Sheet Presentation Views
    @ViewBuilder
    private var activeSheet: some View {
        switch selectedType {
        case .entry:
            AddEditEntrySheet(
                formState: entryFormState,
                isEditing: false,
                onSave: {
                    FeedItemService().createFeedItem(
                        ofType: .entry,
                        with: FeedItemData(
                            title: entryFormState.title,
                            content: entryFormState.content,
                            date: entryFormState.entryDate,
                            impact: nil,
                            tags: entryFormState.tags
                                .split(separator: ",")
                                .map { $0.trimmingCharacters(in: .whitespaces) },
                            status: nil
                        ),
                        context: modelContext
                    )
                    selectedType = nil
                    entryFormState.reset()
                },
                onCancel: {
                    selectedType = nil
                    entryFormState.reset()
                }
            )
        case .outcome:
            AddEditOutcomeSheet(
                formState: outcomeFormState,
                isEditing: false,
                onSave: {
                    FeedItemService().createFeedItem(ofType: .outcome, with: FeedItemData(
                        title: outcomeFormState.title,
                        content: outcomeFormState.details,
                        date: outcomeFormState.accomplishmentDate,
                        impact: outcomeFormState.impact,
                        tags: outcomeFormState.tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) },
                        status: nil
                    ), context: modelContext)
                    selectedType = nil
                    outcomeFormState.reset()
                },
                onCancel: {
                    selectedType = nil
                    outcomeFormState.reset()
                }
            )
        case .task:
            AddEditTaskSheet(
                formState: taskFormState,
                isEditing: false,
                onSave: {
                    FeedItemService().createFeedItem(ofType: .task, with: FeedItemData(
                        title: taskFormState.taskTitle,
                        content: taskFormState.taskDescription,
                        date: nil,
                        impact: nil,
                        tags: taskFormState.tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) },
                        status: taskFormState.status
                    ), context: modelContext)
                    selectedType = nil
                    taskFormState.reset()
                },
                onCancel: {
                    selectedType = nil
                    taskFormState.reset()
                }
            )
        case .none:
            EmptyView()
        }
    }
    
   /* init(testingShowAddItemAlert: Binding<Bool>? = nil) {
        self.externalShowAddItemAlert = testingShowAddItemAlert
    } */
    
    // Master list view
    private var masterView: some View {
        /* ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(feedItems) { item in
                    switch item {
                    case .entry(let entry):
                        FeedCard(entry: entry)
                    case .outcome(let outcome):
                        FeedCard(outcome: outcome)
                    case .task(let task):
                        FeedCard(task: task)
                    }
                }
            }
            .padding(.top, Theme.topPadding)
        } */
        ZStack {
            Color.teal
                .edgesIgnoringSafeArea(.all)
            Text("Hello world.")
                .foregroundColor(.white)
                .font(.largeTitle)
        }
    }
    
        
    var body: some View {
        NavigationSplitView(
            columnVisibility: $columnVisibility,
            preferredCompactColumn: $preferredCompactColumn
        ) {
            masterView
                .toolbar {
                   BragBookToolbar(onAddEntry: { selectedType = .entry })
                }
        } detail: {
            Detail_View()
        }
        .applyNavAppearance()
        .sheet(item: $selectedType) { _ in
            activeSheet
        }
        .globalTopPadding()
        .task {
            feedItems = await FeedViewModel().loadFeedItems(context: modelContext)
        }
    }

    
    
    
    // MARK: - Helpers & Extensions
    /// Resolves an optional external binding by returning it if non-nil, otherwise returns the fallback binding.
    func resolvedBinding<Value>(_ external: Binding<Value>?, fallback: Binding<Value>) -> Binding<Value> {
        external ?? fallback
    }
    
    // MARK: - Previews
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .modelContainer(for: Outcome.self, inMemory: false)
        }
    }
}
