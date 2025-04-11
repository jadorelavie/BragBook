//
//  GlobalModifiers.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 4/11/25.
//
import SwiftUI

struct TopPaddingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 20)
            }
    }
}

extension View {
    func globalTopPadding() -> some View {
        self.modifier(TopPaddingModifier())
    }
}
