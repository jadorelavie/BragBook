//
//  ContentView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 3/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    // Replace the previous state declaration for the alert with a custom binding.
        @State private var internalShowAddItemAlert = false
        // Store the external binding if provided.
        private let externalShowAddItemAlert: Binding<Bool>?
    
        // Computed property: use external binding if available, otherwise use the internal state.
        private var showAddItemAlert: Binding<Bool> {
            return externalShowAddItemAlert ?? $internalShowAddItemAlert
        }
    
    @State private var newTitle: String = ""
    @State private var newDetails: String = ""
    @State private var newOutcome: String = ""
    @State private var newTags: String = ""
    @State private var newImpact: Int?
    @State private var newReviewDate: Date? = nil
    @State private var newAccomplishmentDate = Date()
    
    // Custom initializer to optionally inject an external binding (for testing).
    // When not testing, you can simply call ContentView() and it will use its own internal state.
        init(testingShowAddItemAlert: Binding<Bool>? = nil) {
            self.externalShowAddItemAlert = testingShowAddItemAlert
        }
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        DetailView(item: item)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text(" \(item.accomplishmentDate.formatted(date: .long, time: .omitted))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(item.tags.joined(separator: ", "))
                                .font(.custom("Futura", size: 16))
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .navigationTitle("BragBook")
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            // For macOS, use a sheet for item input.
            .sheet(isPresented: showAddItemAlert) {
                AddItemView(newTitle: $newTitle,
                            newDetails: $newDetails,
                            newTags: $newTags,
                            onSave: {
                                saveItem()
                                showAddItemAlert.wrappedValue = false
                            },
                            onCancel: {
                                showAddItemAlert.wrappedValue = false
                            })
            }
#endif
            .toolbar {
#if os(iOS)
               // ToolbarItem(placement: //
            //  .navigationBarTrailing) {
               //     EditButton()
               // }
#endif
                ToolbarItem {
                    Button(action: { showAddItemAlert.wrappedValue = true }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: showAddItemAlert) {
                AddItemView(
                    newTitle: $newTitle,
                    newDetails: $newDetails,
                    newOutcome: $newOutcome,
                    newTags: $newTags,
                    newImpact: $newImpact,
                    newReviewDate: $newReviewDate,
                    newAccomplishmentDate: $newAccomplishmentDate,
                    onSave: {
                        saveItem()
                        showAddItemAlert.wrappedValue = false
                    },
                    onCancel: {
                        showAddItemAlert.wrappedValue = false
                    }
                )
            }
        } detail: {
            Text("Hello, World!")
        }
    }
    
    private func saveItem() {
        withAnimation {
            let newItem = Item(
                creationDate: Date(),
                title: newTitle,
                details: newDetails,
                tags: newTags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) },
                impact: newImpact,
                reviewDate: newReviewDate,
                accomplishmentDate: newAccomplishmentDate,
                outcome: newOutcome
            )
            
            modelContext.insert(newItem)
            
            // Clear inputs after saving
            newTitle = ""
            newDetails = ""
            newOutcome = ""
            newTags = ""
            newImpact = nil
            newReviewDate = nil
            newAccomplishmentDate = Date()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

// Wrapper view for testing purposes only.
// When you're ready to ship, you can remove ContentViewWrapper and instantiate ContentView() directly.
struct ContentViewWrapper: View {
    @State private var testShowAddItemAlert: Bool = true // Set to true to force the sheet for testing.
    
    var body: some View {
        ContentView(testingShowAddItemAlert: $testShowAddItemAlert)
    }
}

#Preview {
    // Use ContentViewWrapper for testing. For production, use:
    // ContentView()
    ContentViewWrapper()
        .modelContainer(for: Item.self, inMemory: false)
}
