//
//  Home.Swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//

import SwiftUI
import SwiftData

struct FeedItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let date: Date
    let type: String
    let originalObject: any PersistentModel

    static func == (lhs: FeedItem, rhs: FeedItem) -> Bool {
        lhs.id == rhs.id && lhs.originalObject.persistentModelID == rhs.originalObject.persistentModelID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(originalObject.persistentModelID)
    }
}

struct HomeScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [SortDescriptor<JournalEntry>(\.date, order: .reverse)]) private var journalEntries: [JournalEntry]
    @Query(sort: [SortDescriptor<Accomplishment>(\.dateAchieved, order: .reverse)]) private var accomplishments: [Accomplishment]
    @Query(sort: [SortDescriptor<LessonLearned>(\.dateLearned, order: .reverse)]) private var lessonsLearned: [LessonLearned]
    @Query(sort: [SortDescriptor<TaskProject>(\.dateCreated, order: .reverse)]) private var tasksAndProjects: [TaskProject]

    @State private var itemToEdit: (any PersistentModel)? = nil

    private var aggregatedFeed: [FeedItem] {
        var items: [FeedItem] = []
        items.append(contentsOf: journalEntries.map { model in FeedItem(id: model.id, title: model.title, date: model.date, type: "Journal Entry", originalObject: model) })
        items.append(contentsOf: accomplishments.map { model in FeedItem(id: model.id, title: model.title, date: model.dateAchieved, type: "Accomplishment", originalObject: model) })
        items.append(contentsOf: lessonsLearned.map { model in FeedItem(id: model.id, title: model.title, date: model.dateLearned, type: "Lesson Learned", originalObject: model) })
        items.append(contentsOf: tasksAndProjects.map { model in FeedItem(id: model.id, title: model.title, date: model.dateCreated, type: "Task/Project", originalObject: model) })
        return items.sorted { -bash.date > .date }
    }

    var body: some View {
        NavigationView {
            List {
                if aggregatedFeed.isEmpty {
                    Text("No entries yet. Add some to get started!")
                        .foregroundColor(.gray)
                } else {
                    ForEach(aggregatedFeed) { feedItem in
                        VStack(alignment: .leading) {
                            Text(feedItem.title).font(.headline)
                            Text("\(feedItem.date, style: .date) - \(feedItem.type)").font(.caption).foregroundColor(.gray)
                        }
                        // CRUD interactions (Button, .onDelete) will be added to this ForEach in Phase 1
                    }
                }
            }
            .navigationTitle("BragBook Feed")
            // CRUD Toolbar and .sheet will be added in Phase 1
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: JournalEntry.self, Accomplishment.self, LessonLearned.self, TaskProject.self, configurations: config)
        container.mainContext.insert(JournalEntry(title: "Preview Journal Entry", text: "Some text for the journal.", date: Date().addingTimeInterval(-86400 * 2)))
        container.mainContext.insert(Accomplishment(title: "Preview Accomplishment", descriptionText: "Details about the accomplishment.", dateAchieved: Date().addingTimeInterval(-86400)))
        return HomeScreen().modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
