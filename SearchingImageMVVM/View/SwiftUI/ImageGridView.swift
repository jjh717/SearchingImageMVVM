import SwiftUI

struct ImageGridView: View {

    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                PinterestGrid(viewModel.photos, columns: 2, spacing: 8) { photo in
                    ImageCardView(photo: photo)
                        .task {
                            await viewModel.loadMoreIfNeeded(currentItem: photo)
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
