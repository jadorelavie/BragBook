//
//  DetailView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 4/8/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Bindable var item: Item
    @State private var showingEdit = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(item.title).font(.title)

            Text(item.accomplishmentDate.formatted(date: .long, time: .omitted))
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(item.details)
            
            if let impact = item.impact {
                Text("Impact: \(impactDescription(impact))")
            }
            if let outcome = item.outcome, !outcome.isEmpty {
                HStack {
                    Text("Outcome:")
                        .font(.headline)
                    Text(outcome)
                        .font(.body)
                }
            }
                                               
            if let reviewDate = item.reviewDate {
                Text("Review Date: \(reviewDate.formatted(.dateTime.month().day().year()))")
            }
            
            if !item.tags.isEmpty {
                Text("Tags: \(item.tags.joined(separator: ", "))")
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
            EditItemView(item: item)
        }
    }

    private func impactDescription(_ impact: Int) -> String {
        switch impact {
        case 0: return "Detrimental"
        case 1: return "Helped at Individual Level"
        case 2: return "Helped at Team Level"
        case 3: return "Helped at Department Level"
        case 4: return "Helped at Organization Level"
        case 5: return "Helped Beyond Organization"
        default: return "TBD"
        }
    }
}
