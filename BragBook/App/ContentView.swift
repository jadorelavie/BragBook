//
//  ContentView.swift
//  BragBook
//
//  Created by Taryn Brice-Rowland on 5/26/25.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authService: AuthenticationService

    var body: some View {
        // If authenticated, show HomeScreen, otherwise show current placeholder
        // The previous "Welcome to BragBook" text will now be inside HomeScreen or handled by it
        HomeScreen()
        // No more "You are signed in" text here, HomeScreen is the main UI.
        // Sign out button could be moved to a profile screen or settings in HomeScreen later.
        // For simplicity in this step, we remove the sign-out button from here.
        // It can be added to HomeScreen's toolbar if needed.
    }
}

#Preview {
    // ContentView preview might also need a model container if HomeScreen needs it.
    // And authService for its environment object.
    do {
        let schema = Schema([
            JournalEntry.self, Accomplishment.self, LessonLearned.self, TaskProject.self
        ])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: config)
        
        return ContentView()
            .environmentObject(AuthenticationService()) // Mock auth service for preview
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

