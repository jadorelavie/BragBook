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
            Text(item.details)
                    
            if let impact = item.impact {
                Text("Impact: \(impactDescription(impact))")
            }
            
            if let outcome = item.outcome {
                HStack {
                    Text("Outcome:")
                        .font(.headline)
                    Text(outcome)
                        .font(.body)
                }
            }
            
            Text("Accomplished on \(item.accomplishmentDate.formatted())")
                            .foregroundColor(.gray)
                        
            if let reviewDate = item.reviewDate {
                Text("Review Date: \(reviewDate.formatted(.dateTime.month().day().year()))")
            }
            
            Text("Tags: \(item.tags.joined(separator: ", "))")
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Celebrate!")
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
        case 0: return "Negative"
        case 1: return "Individual"
        case 2: return "Team"
        case 3: return "Department"
        case 4: return "Organization"
        case 5: return "Beyond Organization"
        default: return "TBD"
        }
    }
}
