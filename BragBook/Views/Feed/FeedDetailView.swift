//
//  DetailView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 4/8/25.
//

import SwiftUI
import SwiftData

struct FeedDetailView: View {
    @StateObject var viewModel: FeedDetailViewModel
    @State private var showingEdit = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            /*Text(viewModel.title).font(.title)*/
            
            Text(viewModel.formattedDate)
                .font(.subheadline)
                .foregroundColor(.gray)
            /*Text(viewModel.outcome.details)*/
            
            /*if viewModel.impact != nil {*/
            Text("Impact: \(viewModel.impactDescriptionText)")
        }
        
        
        /*if let reviewDate = viewModel.outcome.reviewDate {
         Text("Review Date: \(reviewDate.formatted(.dateTime.month().day().year()))")
         }*/
        
        /* if !viewModel.outcome.tags.isEmpty {
         Text("Tags: \(viewModel.outcome.tags.joined(separator: ", "))")
         .foregroundColor(.gray)
         }
         Spacer()
         }
         .padding()
         .navigationTitle("Kudos!")
         .toolbar {
         Button("Edit") {
         showingEdit = true
         }
         }
         .sheet(isPresented: $showingEdit) {
         switch viewModel.feedItem {
         case .entry(let entry):
         AddEditEntrySheet(formState: EntryFormState(entry), isEditing: true, ...)
         case .outcome(let outcome):
         AddEditOutcomeSheet(formState: OutcomeFormState(outcome), isEditing: true, ...)
         case .task(let task):
         AddEditTaskSheet(formState: TaskFormState(task), isEditing: true, ...)
         }
         }
         }
         
         }*/
    }
}
