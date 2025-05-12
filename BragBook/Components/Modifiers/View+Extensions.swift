//
//  View+Extensions.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/9/25.
//

import SwiftUI

// MARK: - Add Button
extension View {
  func bragBookAddButton(showing: Binding<Bool>) -> some View {
    self.toolbar { BragBookToolbar(showingAddOutcome: showing) }
  }
}
