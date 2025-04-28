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
    
    // Set title text attributes (Futura, 32pt, Galaxy Blue)
    // Hex color #1f3c6b = RGB(31, 60, 107)
    appearance.titleTextAttributes = [
        .foregroundColor: UIColor(red: 0/255, green: 135/255, blue: 172/255, alpha: 1.0),
        .font: UIFont(name: "Futura", size: 32)!
    ]
    
    // Set large title text attributes (Futura, 40pt, Galaxy Blue)
    appearance.largeTitleTextAttributes = [
        .foregroundColor: UIColor(red: 0/255, green: 135/255, blue: 172/255, alpha: 1.0),
        .font: UIFont(name: "Futura", size: 40)!
    ]
    
    // Apply the appearance to all navigation bars.
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}
