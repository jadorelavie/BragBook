//
//  BragCard.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/9/25.
//

import SwiftUI

extension View {
    func bragCardStyle() -> some View {
        self
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .buttonStyle(PlainButtonStyle()) // removes disclosure arrows if used on a button
    }
}
