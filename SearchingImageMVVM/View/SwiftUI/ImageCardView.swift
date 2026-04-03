import SwiftUI

struct ImageCardView: View {

    let photo: UnsplashPhoto

    var body: some View {
        AsyncImage(url: URL(string: photo.urls.small)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)

            case .failure:
                Color.gray.opacity(0.3)
                    .aspectRatio(1 / photo.aspectRatio, contentMode: .fit)
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.secondary)
                    }

            case .empty:
                Color.gray.opacity(0.1)
                    .aspectRatio(1 / photo.aspectRatio, contentMode: .fit)
                    .overlay { ProgressView() }

            @unknown default:
                Color.clear
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
