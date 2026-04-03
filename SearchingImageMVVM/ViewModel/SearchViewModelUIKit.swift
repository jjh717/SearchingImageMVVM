import Foundation
import Combine

final class SearchViewModelUIKit {

    @Published private(set) var photos: [UnsplashPhoto] = []
    @Published private(set) var isLoading = false

    private var currentPage = 1
    private var canLoadMore = true

    @MainActor
    func loadInitial() async {
        currentPage = 1
        canLoadMore = true
        photos = []
        await fetchPhotos()
    }

    @MainActor
    func loadMore() async {
        guard !isLoading, canLoadMore else { return }
        await fetchPhotos()
    }

    @MainActor
    private func fetchPhotos() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let newPhotos = try await APIClient.fetchPhotos(page: currentPage)
            if newPhotos.isEmpty {
                canLoadMore = false
            } else {
                photos.append(contentsOf: newPhotos)
                currentPage += 1
            }
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
    }
}
