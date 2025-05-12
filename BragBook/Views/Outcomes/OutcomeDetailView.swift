//
//  DetailView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 4/8/25.
//

import SwiftUI
import SwiftData

struct OutcomeDetailView: View {
    @StateObject var viewModel: OutcomeDetailViewModel
    @State private var showingEdit = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.outcome.title).font(.title)

            Text(viewModel.formattedDate)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(viewModel.outcome.details)
            
            if viewModel.outcome.impact != nil {
                Text("Impact: \(viewModel.impactDescriptionText)")
            }
            if let outcomeText = viewModel.outcome.outcome, !outcomeText.isEmpty {
                HStack {
                    Text("Outcome:")
                        .font(.headline)
                    Text(outcomeText)
                        .font(.body)
                }
            }
                                               
            if let reviewDate = viewModel.outcome.reviewDate {
                Text("Review Date: \(reviewDate.formatted(.dateTime.month().day().year()))")
            }
            
            if !viewModel.outcome.tags.isEmpty {
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
            EditOutcomeView(outcome: viewModel.outcome)
        }
    }
    
}
