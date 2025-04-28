//
//  Theme.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 4/23/25.
//


import SwiftUI

/// Centralized style constants for BragBook.
enum Theme {
    // MARK: Colors
    static let primaryTextColor = Color(hex: "#1f3c6b")
    static let darkTealColor    = Color(hex: "#007889")
    static let tagBackground    = Color(hex: "#7f4f8e")

    // MARK: Layout
    static let horizontalPadding: CGFloat = 20
    static let verticalPadding:   CGFloat = 4
    static let topPadding:        CGFloat = 0
    static let cardCornerRadius:  CGFloat = 12

    // MARK: Shadow
    static let shadowColor  = primaryTextColor.opacity(0.35)
    static let shadowRadius: CGFloat = 4
    static let shadowX:      CGFloat = 0
    static let shadowY:      CGFloat = 3

    // MARK: Fonts
    static let titleFontName   = "Futura-Bold"
    static let bodyFontName    = "Futura-Regular"
    static let captionFontName = "Futura"
    static let tagFontSize:    CGFloat = 14
    static let bodyFontSize:   CGFloat = 16
    static let titleFontSize:  CGFloat = 32
}
