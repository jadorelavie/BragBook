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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
                .environment(\.font, .custom("GillSans-Regular", size: 16))
                .foregroundColor(Color(hex: "#1f3c6b"))
            }
    }
}
