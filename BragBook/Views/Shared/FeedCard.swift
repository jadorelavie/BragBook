//
//  FeedCardView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/9/25.
//

// MARK: - Imports
import SwiftUI
import SwiftData


// MARK: - View
struct FeedCard: View {
    let feedItem: FeedItem

    var body: some View {
        switch feedItem {
        case .outcome(let outcome):
            VStack(alignment: .leading, spacing: 6) {
                Text(outcome.title)
                    .font(.headline)
                    .foregroundColor(Theme.primaryTextColor)
                Text(outcome.accomplishmentDate.formatted(date: .long, time: .omitted))
                    .font(.subheadline)
                    .foregroundColor(Theme.primaryTextColor)
                if !outcome.tags.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(outcome.tags, id: \.self) { tag in
                            TagPill(tag: tag)
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)

        case .entry(let entry):
            VStack(alignment: .leading, spacing: 6) {
                Text(entry.title)
                    .font(.headline)
                    .foregroundColor(Theme.primaryTextColor)
                Text(entry.entryDate.formatted(date: .long, time: .omitted))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(entry.content)
                    .font(.body)
                    .lineLimit(3)
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)

        case .task(let task):
            VStack(alignment: .leading, spacing: 6) {
                Text(task.taskTitle)
                    .font(.headline)
                    .foregroundColor(Theme.primaryTextColor)
                if !task.taskDescription.isEmpty {
                    Text(task.taskDescription)
                        .font(.body)
                        .lineLimit(2)
                        .foregroundColor(.primary)
                }
                Text("Status: \(task.status.rawValue.capitalized)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
        }
    }
}
