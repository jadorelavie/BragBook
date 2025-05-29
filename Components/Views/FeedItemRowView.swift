//
//  FeedItemRowView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/28/25.
//


//
//  FeedItemRowView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/28/25.
//


import SwiftUI
import CoreData

struct FeedItemRowView: View {
    let feedItem: FeedItem
    @ObservedObject var viewModel: FeedViewModel // For potential actions like navigation
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        if let journalEntry = feedItem.item as? JournalEntry {
            // NavigationLink to AddEditJournalEntryView for journal entries
            NavigationLink(destination: AddEditJournalEntryView(viewModel: JournalViewModel(context: viewContext), entryToEdit: journalEntry)) {
                VStack(alignment: .leading) {
                    Text(journalEntry.title).font(.headline)
                    Text(journalEntry.date, style: .date).font(.subheadline)
                }
            }
        } else if let accomplishment = feedItem.item as? Accomplishment {
            // New section for Accomplishment
            VStack(alignment: .leading) {
                Text("Accomplishment").font(.headline) // Generic title for now
                Text("Created: \(accomplishment.creationDate, style: .date)").font(.subheadline)
                Text("Linked Journal ID: \(accomplishment.journalEntryID.uuidString)").font(.caption).foregroundColor(.gray)
                
                if let impact = accomplishment.impact {
                    Text("Impact: \(impact)/5").font(.footnote)
                }
                if let outcome = accomplishment.outcome, !outcome.isEmpty {
                    Text("Outcome: \(outcome)").font(.footnote).lineLimit(2)
                }
                if let reviewDate = accomplishment.reviewDate {
                    Text("Next Review: \(reviewDate, style: .date)").font(.caption).foregroundColor(.orange)
                }
            }
            // Accomplishments are not interactive in this iteration (no NavigationLink)
        } else {
            // Existing placeholder for other feed item types
            Text("Unsupported feed item type (Placeholder in RowView)")
        }
    }
}

// Basic Preview (Optional, but good practice)
// For preview to work, you'd need a sample FeedItem and FeedViewModel.
// This might be complex to set up here perfectly without running Xcode.
// struct FeedItemRowView_Previews: PreviewProvider {
//     static var previews: some View {
//         // Assuming you have a way to create a sample JournalEntry and Accomplishment for FeedItem
//         // let sampleJournalEntry = JournalEntry(title: "Sample Journal", text: "Text", date: Date())
//         // let sampleAccomplishment = Accomplishment(journalEntryID: UUID(), creationDate: Date())
//         // let feedItemJournal = FeedItem(item: sampleJournalEntry)
//         // let feedItemAccomplishment = FeedItem(item: sampleAccomplishment)
//         // let sampleViewModel = FeedViewModel(persistenceController: .preview)
//
//         // VStack {
//         //     FeedItemRowView(feedItem: feedItemJournal, viewModel: sampleViewModel)
//         //     FeedItemRowView(feedItem: feedItemAccomplishment, viewModel: sampleViewModel)
//         // }
//         // .previewLayout(.sizeThatFits)
//         Text("Preview for FeedItemRowView (requires setup)")
//     }
// }
