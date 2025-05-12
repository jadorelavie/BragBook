//
//  OutcomeFormState.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/7/25.
//

import Foundation
import SwiftUI

class OutcomeFormState: ObservableObject {
    @Published var title: String = ""
    @Published var accomplishmentDate: Date = Date()
    @Published var details: String = ""
    @Published var tags: String = ""
    @Published var outcome: String = ""
    @Published var impact: Int? = nil
    @Published var reviewDate: Date? = nil

    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
