import SwiftUI

struct ImageGridView: View {

    @StateObject private var viewModel = SearchViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.photos) { photo in
                        ImageCardView(photo: photo)
                            .task {
                                await viewModel.loadMoreIfNeeded(currentItem: photo)
                            }
                    }
                }
                .padding(8)

                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .navigationTitle("Unsplash")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await viewModel.loadInitial()
        }
    }
}

#Preview {
    ImageGridView()
}
