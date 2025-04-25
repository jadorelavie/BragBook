import SwiftUI

/// View extension to apply global navigation bar styling across the app.
extension View {
    /// Applies consistent navigation bar tint, hides the bottom separator,
    /// and clears the background for a clean toolbar appearance.
    func applyNavAppearance() -> some View {
        self
            // Set accent/tint color for navigation items (e.g., + button).
            .tint(Color(hex: "#1f3c6b"))
            // Hide the default navigation bar bottom separator.
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarBackground(Color.clear, for: .navigationBar)
    }
}
