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
                .environment(\.font, .custom("Futura", size: 18))
                .modelContainer(for: Item.self)
        }
    }
}
