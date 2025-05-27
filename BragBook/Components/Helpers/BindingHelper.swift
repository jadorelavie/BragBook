import SwiftUI

/// Displays when there are no entries in the master list.
struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("No entries yet—tap + to add your first accomplishment")
                .font(.headline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}
