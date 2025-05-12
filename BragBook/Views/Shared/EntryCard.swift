//
//  EntryCard.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/9/25.
//

// MARK: - Imports
import SwiftUI
import SwiftData

struct EntryCard: View {
    let outcome: Outcome

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(outcome.title)
                .font(.headline)
                .foregroundColor(Theme.primaryTextColor)
            Text(outcome.accomplishmentDate.formatted(date: .long, time: .omitted))
                .font(.subheadline)
                .foregroundColor(Theme.primaryTextColor)
            if !outcome.tags.isEmpty {
                HStack(spacing: 6) {
                    ForEach(outcome.tags, id: \.self) { t in
                        TagPill(tag: t)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "\(outcome.title), accomplished on " +
            "\(outcome.accomplishmentDate.formatted(date: .long, time: .omitted))" +
            (outcome.tags.isEmpty ? "" : ", tags: \(outcome.tags.joined(separator: ", "))")
        )
    }
}
