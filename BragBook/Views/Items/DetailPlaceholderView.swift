//
//  DetailPlaceholderView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 4/23/25.
//

import SwiftUI

/// Placeholder view when no item is selected in the master list.
struct DetailPlaceholderView: View {
    var body: some View {
        Text("Select an entry to view details")
            .font(.headline)
            .foregroundColor(.gray)
    }
}
