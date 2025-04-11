//
//  BragBookApp.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 3/10/25.
//

import SwiftUI
import SwiftData

@main
struct BragBookApp: App {
    
    init() {
        setupNavigationBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
                .globalTopPadding()
                .environment(\.font, .custom("GillSans-Regular", size: 16))
                .foregroundColor(Color(hex: "#1f3c6b"))
            }
        
        
    }
}


/// Configures the global appearance for all UINavigationBars.
/// This uses Gill Sans Bold for the navigation titles and the colors from your style guide.
func setupNavigationBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    
    // Set background color (e.g., white; adjust if needed)
    appearance.backgroundColor = .white
    
    // Set title text attributes (Gill Sans Bold, 32pt, Dark Teal)
    // Convert hex color #0e4a47 to RGB: (14/255, 74/255, 71/255)
    appearance.titleTextAttributes = [
        .foregroundColor: UIColor(red: 14/255, green: 74/255, blue: 71/255, alpha: 1.0),
        .font: UIFont(name: "Futura", size: 32)!
    ]
    
    // Set large title text attributes (Gill Sans Bold, 40pt, Dark Teal)
    appearance.largeTitleTextAttributes = [
        .foregroundColor: UIColor(red: 14/255, green: 74/255, blue: 71/255, alpha: 1.0),
        .font: UIFont(name: "Futura", size: 40)!
    ]
    
    // Apply the appearance to all navigation bars.
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}
