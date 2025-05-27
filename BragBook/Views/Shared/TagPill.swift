//
//  TagPill.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/9/25.
//
// MARK: - Imports
import SwiftUI
import SwiftData

struct TagPill: View {
    let tag: String
    var body: some View {
        Text(tag)
            .font(.custom(Theme.captionFontName, size: Theme.tagFontSize, relativeTo: .caption))
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Theme.tagBackground)
            .cornerRadius(8)
            .accessibilityLabel("Tag: \(tag)")
            .accessibilityAddTraits(.isStaticText)
    }
}
