import SwiftUI
import SwiftData

struct OutcomeListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = OutcomeListViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.sortedOutcomes) { outcome in
                        NavigationLink(destination: OutcomeDetailView(viewModel: OutcomeDetailViewModel(outcome: outcome))) {
                            EntryCard(outcome: outcome)
                        }
                        .bragCardStyle()
                    }
                }
                .padding()
            }
            .navigationTitle("Outcomes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.sortDescending.toggle()
                        viewModel.loadOutcomes(context: modelContext)
                    }) {
                        Image(systemName: viewModel.sortDescending ? "arrow.down" : "arrow.up")
                    }
                }
            }
            .onAppear {
                viewModel.loadOutcomes(context: modelContext)
            }
        }
    }
}

#Preview {
    OutcomeListView()
}
