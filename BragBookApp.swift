//
//  BragBookApp.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/28/25.
//

import SwiftUI
import CoreData

@main
struct BragBookApp: App {
    // Shared Core Data stack
    let persistenceController = PersistenceController.shared
    // FeedViewModel using the shared viewContext
    @StateObject private var feedViewModel = FeedViewModel(context: PersistenceController.shared.container.viewContext)

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: feedViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
