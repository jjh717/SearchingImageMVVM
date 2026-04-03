import Foundation

@MainActor
final class SearchViewModel: ObservableObject {

    @Published private(set) var photos: [UnsplashPhoto] = []
    @Published private(set) var isLoading = false

    private var currentPage = 1
    private var canLoadMore = true

    func loadInitial() async {
        currentPage = 1
        canLoadMore = true
        photos = []
        await fetchPhotos()
    }

    func loadMoreIfNeeded(currentItem: UnsplashPhoto) async {
        guard let lastItem = photos.last,
              lastItem.id == currentItem.id,
              !isLoading,
              canLoadMore else { return }

        await fetchPhotos()
    }

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
