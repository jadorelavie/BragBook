// MARK: - Imports
import SwiftUI
import SwiftData

// MARK: - Reusable Views

struct TagPill: View {
    let tag: String
    var body: some View {
        Text(tag)
            .font(.custom(Theme.captionFontName, size: Theme.tagFontSize, relativeTo: .caption))
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Theme.tagBackground)
            .cornerRadius(8)
            .accessibilityLabel("Tag: \(tag)")
            .accessibilityAddTraits(.isStaticText)
    }
}

struct EntryCard: View {
    let item: Item

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(item.title)
                .font(.headline)
                .foregroundColor(Theme.primaryTextColor)
            Text(item.accomplishmentDate.formatted(date: .long, time: .omitted))
                .font(.subheadline)
                .foregroundColor(Theme.primaryTextColor)
            if !item.tags.isEmpty {
                HStack(spacing: 6) {
                    ForEach(item.tags, id: \.self) { t in
                        TagPill(tag: t)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(Theme.cardCornerRadius)
        .shadow(color: Theme.shadowColor,
                radius: Theme.shadowRadius,
                x: Theme.shadowX,
                y: Theme.shadowY)
        .padding(.horizontal, Theme.horizontalPadding)
        .padding(.vertical, Theme.verticalPadding)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "\(item.title), accomplished on " +
            "\(item.accomplishmentDate.formatted(date: .long, time: .omitted))" +
            (item.tags.isEmpty ? "" : ", tags: \(item.tags.joined(separator: ", "))")
        )
    }
}

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

    /// Saves a new Item into the given ModelContext.
    ///
    /// - Parameter context: The SwiftData ModelContext used to insert the new Item.
    /// After insertion, input fields are reset.
    func saveItem(context: ModelContext) {
        withAnimation {
            let entry = Item(
                creationDate: Date(),
                title: newTitle,
                details: newDetails,
                tags: newTags
                      .split(separator: ",")
                      .map { $0.trimmingCharacters(in: .whitespaces) },
                impact: newImpact,
                reviewDate: newReviewDate,
                accomplishmentDate: newAccomplishmentDate,
                outcome: newOutcome
            )
            context.insert(entry)
            resetFields()
        }
    }

    /// Deletes existing Items at the specified offsets.
    ///
    /// - Parameters:
    ///   - offsets: IndexSet of items to remove.
    ///   - items:   Current Items array.
    ///   - context: SwiftData ModelContext for the deletion.
    func deleteItems(offsets: IndexSet, items: [Item], context: ModelContext) {
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
    @Binding var showingAddItem: Bool

    var body: some ToolbarContent {
        ToolbarItem {
            Button(action: { showingAddItem = true }) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }
}

// MARK: - Main View

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @State private var internalShowAddItemAlert = false
    private let externalShowAddItemAlert: Binding<Bool>?
    private var showAddItemAlert: Binding<Bool> {
        resolvedBinding(externalShowAddItemAlert, fallback: $internalShowAddItemAlert)
    }

    @StateObject private var vm = ContentViewModel()
    @State private var selectedItem: Item? = nil

    init(testingShowAddItemAlert: Binding<Bool>? = nil) {
        self.externalShowAddItemAlert = testingShowAddItemAlert
    }

    // Master list view
    private var masterView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items) { item in
                    NavigationLink(value: item) {
                        EntryCard(item: item)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .onDelete { offsets in
                    vm.deleteItems(offsets: offsets,
                                   items: items,
                                   context: modelContext)
                }
            }
            .padding(.top, Theme.topPadding)
        }
    }

    // Add-item sheet
    private var addItemSheet: some View {
        AddItemView(
            newTitle: $vm.newTitle,
            newDetails: $vm.newDetails,
            newOutcome: $vm.newOutcome,
            newTags: $vm.newTags,
            newImpact: $vm.newImpact,
            newReviewDate: $vm.newReviewDate,
            newAccomplishmentDate: $vm.newAccomplishmentDate,
            onSave: {
                vm.saveItem(context: modelContext)
                showAddItemAlert.wrappedValue = false
            },
            onCancel: {
                showAddItemAlert.wrappedValue = false
            }
        )
    }

    var body: some View {
        NavigationSplitView {
            Group {
                if items.isEmpty {
                    EmptyStateView()
                } else {
                    masterView
                        .navigationDestination(for: Item.self) { item in
                            DetailView(item: item)
                        }
                }
            }
            .toolbar {
                BragBookToolbar(showingAddItem: showAddItemAlert)
            }
        } detail: {
            if let item = selectedItem {
                DetailView(item: item)
            } else {
                DetailPlaceholderView()
            }
        }
        .applyNavAppearance()
        .background(Color.white) // Ensures light background behind nav bar
        .sheet(isPresented: showAddItemAlert) {
            addItemSheet
        }
        .globalTopPadding()
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
            .modelContainer(for: Item.self, inMemory: false)
    }
}
