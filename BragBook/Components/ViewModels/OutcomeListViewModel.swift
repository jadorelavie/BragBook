//
//  OutcomeListViewModel.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/7/25.
//

import Foundation
import SwiftUI
import SwiftData

class OutcomeListViewModel: ObservableObject {
    @Published var outcomes: [Outcome] = []
    @Published var sortDescending: Bool = true

    var sortedOutcomes: [Outcome] {
        outcomes.sorted {
            sortDescending
            ? $0.accomplishmentDate > $1.accomplishmentDate
            : $0.accomplishmentDate < $1.accomplishmentDate
        }
    }

    func loadOutcomes(context: ModelContext) {
        let fetchDescriptor = FetchDescriptor<Outcome>(
            sortBy: [
                SortDescriptor(\.accomplishmentDate, order: sortDescending ? .reverse : .forward)
            ]
        )
        do {
            outcomes = try context.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch outcomes: \(error.localizedDescription)")
            outcomes = []
        }
    }
}
