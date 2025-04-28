//
//  Typography.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 4/10/25.
//
import SwiftUI

// MARK: - Hex Color Extension
extension Color {
    /// Initializes a Color from a hex string, e.g. "#0e4a47"
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue >> 16) & 0xff) / 255.0
        let g = Double((rgbValue >> 8) & 0xff) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Typography Style Modifiers

/// App Title: Gill Sans or Futura, Bold, 32–40 pt, Dark Teal (#0e4a47)
struct AppTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        // Using Futura Bold at 36 pt as an example.
        content
            .font(.custom("Futura-Bold", size: 36))
            .foregroundColor(Color(hex: "#0e4a47"))
    }
}

/// Section Headers: Gill Sans, Semibold, 24 pt, Dark Teal (#0e4a47)
struct SectionHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("GillSans-Semibold", size: 24))
            .foregroundColor(Color(hex: "#0e4a47"))
    }
}

/// Subheadings: Gill Sans, Regular, 18 pt, Galaxy Blue (#1f3c6b)
struct SubheadingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("GillSans-Regular", size: 18))
            .foregroundColor(Color(hex: "#1f3c6b"))
    }
}

/// Body Text: Gill Sans, Regular, 16 pt, Galaxy Blue (#1f3c6b)
struct BodyTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("GillSans-Regular", size: 16))
            .foregroundColor(Color(hex: "#1f3c6b"))
    }
}

/// Labels / Meta Info: Gill Sans, Light, 14 pt, Muted Violet (#7f4f8e)
struct LabelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("GillSans-Light", size: 14))
            .foregroundColor(Color(hex: "#7f4f8e"))
    }
}

/// Button Text: Futura, Bold, 18 pt, White (to be used on Peacock Green background: #328d7a)
struct ButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Futura-Bold", size: 18))
            .foregroundColor(.white)
    }
}

// MARK: - Button Style

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(ButtonTextModifier())
            .padding()
            .background(Color(hex: "#328d7a"))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

// MARK: - View Extension for Easy Use

extension View {
    func appTitleStyle() -> some View {
        self.modifier(AppTitleModifier())
    }
    
    func sectionHeaderStyle() -> some View {
        self.modifier(SectionHeaderModifier())
    }
    
    func subheadingStyle() -> some View {
        self.modifier(SubheadingModifier())
    }
    
    func bodyTextStyle() -> some View {
        self.modifier(BodyTextModifier())
    }
    
    func labelStyle() -> some View {
        self.modifier(LabelModifier())
    }
    
    func buttonTextStyle() -> some View {
        self.modifier(ButtonTextModifier())
    }
}
