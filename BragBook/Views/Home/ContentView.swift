// MARK: - Imports
import SwiftUI
import SwiftData


// MARK: - View Model

/// ViewModel for ContentView.
/// Manages the state for creating new entries and handles persistence.
final class ContentViewModel: ObservableObject {
    @Published var newTitle: String = ""
    @Published var newDetails: String = ""
    @Published var newOutcome: String = ""
    @Published var newTags: String = ""
    @Published var newImpact: Int?    = nil
    @Published var newReviewDate: Date? = nil
    @Published var newAccomplishmentDate: Date = Date()

    /// Saves a new Outcome into the given ModelContext.
    ///
    /// - Parameter context: The SwiftData ModelContext used to insert the new Outcome.
    /// After insertion, input fields are reset.
    func saveOutcome(context: ModelContext) {
        withAnimation {
            let entry = Outcome(
                creationDate: Date(),
                title: newTitle,
                accomplishmentDate: newAccomplishmentDate,
                details: newDetails,
                tags: newTags
                      .split(separator: ",")
                      .map { $0.trimmingCharacters(in: .whitespaces) },
                impact: newImpact,
                reviewDate: newReviewDate,
                outcome: newOutcome
            )
            context.insert(entry)
            resetFields()
        }
    }

    /// Deletes existing Outcomes at the specified offsets.
    ///
    /// - Parameters:
    ///   - offsets: IndexSet of outcomes to remove.
    ///   - items:   Current Outcomes array.
    ///   - context: SwiftData ModelContext for the deletion.
    func deleteOutcomes(offsets: IndexSet, items: [Outcome], context: ModelContext) {
        withAnimation {
            for idx in offsets {
                context.delete(items[idx])
            }
        }
    }

    /// Resets all entry input fields to default values.
    private func resetFields() {
        newTitle = ""
        newDetails = ""
        newOutcome = ""
        newTags = ""
        newImpact = nil
        newReviewDate = nil
        newAccomplishmentDate = Date()
    }
}

// MARK: - Toolbar

struct BragBookToolbar: ToolbarContent {
    @Binding var showingAddOutcome: Bool

    var body: some ToolbarContent {
        ToolbarItem {
            Button(action: { showingAddOutcome = true }) {
                Label("Add Outcome", systemImage: "plus")
            }
        }
    }
}

// MARK: - Main View

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var outcomes: [Outcome]
    
    @State private var internalShowAddItemAlert = false
    private let externalShowAddItemAlert: Binding<Bool>?
    private var showAddItemAlert: Binding<Bool> {
        resolvedBinding(externalShowAddItemAlert, fallback: $internalShowAddItemAlert)
    }
    
    // @StateObject private var vm = ContentViewModel()
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var preferredCompactColumn: NavigationSplitViewColumn = .sidebar
    @State private var selectedOutcome: Outcome? = nil
    
    init(testingShowAddItemAlert: Binding<Bool>? = nil) {
        self.externalShowAddItemAlert = testingShowAddItemAlert
    }
    
    // Master list view
    private var masterView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(outcomes) { outcome in
                    NavigationLink(value: outcome) {
                        EntryCard(outcome: outcome)
                    }
                    .bragCardStyle()
                }
                .onDelete { offsets in
                    withAnimation {
                        for idx in offsets {
                            modelContext.delete(outcomes[idx])
                        }
                    }
                }
            }
            .padding(.top, Theme.topPadding)
        }
    }
    
    // Add-item sheet
    private var addItemSheet: some View {
        AddOutcomeView(
            onSave: { outcome in
                modelContext.insert(outcome)
                showAddItemAlert.wrappedValue = false
            },
            onCancel: {
                showAddItemAlert.wrappedValue = false
            }
        )
    }
    
    var body: some View {
        NavigationSplitView(
            columnVisibility: $columnVisibility,
            preferredCompactColumn: $preferredCompactColumn
        ) {
            if outcomes.isEmpty {
                EmptyStateView()
                    .toolbar {
                        BragBookToolbar(showingAddOutcome: showAddItemAlert)
                    }
            } else {
                OutcomeListView()
                    .toolbar {
                        BragBookToolbar(showingAddOutcome: showAddItemAlert)
                    }
            }
        } detail: {
            if let outcome = selectedOutcome {
                OutcomeDetailView(viewModel: OutcomeDetailViewModel(outcome: outcome))
            } else {
                DetailPlaceholderView()
            }
        }
        .applyNavAppearance()
        .sheet(isPresented: showAddItemAlert) {
            addItemSheet
        }
        .globalTopPadding()
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
