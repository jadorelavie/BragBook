
//
//  OutcomeFormFieldView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/4/25.
//

import SwiftUI

/// A reusable form component containing all fields for creating or editing an Outcome.
/// Usage:
/// OutcomeFormFieldsView(
///     title: $vm.title,
///     details: $vm.details,
///     tags: $vm.tags,
///     outcome: $vm.outcome,
///     impact: $vm.impact,
///     reviewDate: $vm.reviewDate,
///     accomplishmentDate: $vm.accomplishmentDate
/// )
struct OutcomeFormFieldsView: View {
    @Binding var title: String
    @Binding var accomplishmentDate: Date
    @Binding var details: String
    @Binding var tags: String
    @Binding var impact: Int?
    @Binding var outcome: String
    @Binding var reviewDate: Date?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Basic Info group
                Text("Basic Info")
                    .font(.headline)
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                    DatePicker("Accomplishment Date", selection: $accomplishmentDate, displayedComponents: .date)
                }

                // Details group
                Text("Details")
                    .font(.headline)
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Details", text: $details, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                        .textFieldStyle(.roundedBorder)
                    TextField("Tags (comma separated)", text: $tags)
                        .textFieldStyle(.roundedBorder)
                }

                // Outcome group
                Text("Impact")
                    .font(.headline)
                VStack(alignment: .leading, spacing: 8) {
                    Picker("Impact", selection: Binding(get: { impact ?? -1 }, set: { impact = $0 })) {
                        ForEach(0...5, id: \.self) { value in
                            Text(impactDescription(value)).tag(value)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Outcome", text: $outcome, axis: .vertical)
                            .lineLimit(5, reservesSpace: true)
                            .textFieldStyle(.roundedBorder)
                    }
                }

                // Review Date group
                Text("Check-In")
                    .font(.headline)
                VStack(alignment: .leading, spacing: 2) {
                    DatePicker("Review Date", selection: Binding(get: { reviewDate ?? Date() }, set: { reviewDate = $0 }), displayedComponents: .date)
                }
            }
            .padding()
        }
    }
}


private func impactDescription(_ impact: Int) -> String {
    switch impact {
    case 0: return "This hurt; it didn't help."
    case 1: return "This made my life better."
    case 2: return "This made my team's life better."
    case 3: return "This made my department better."
    case 4: return "This made my organization better."
    case 5: return "The reach of this effort helps beyond my immediate organization."
    default: return "TBD"
    }
}
