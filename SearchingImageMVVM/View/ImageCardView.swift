import SwiftUI

struct ImageCardView: View {

    let photo: UnsplashPhoto

    var body: some View {
        AsyncImage(url: URL(string: photo.urls.small)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)

            case .failure:
                Color.gray.opacity(0.3)
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.secondary)
                    }

            case .empty:
                Color.gray.opacity(0.1)
                    .overlay { ProgressView() }

            @unknown default:
                Color.clear
            }
        }
        .aspectRatio(1 / photo.aspectRatio, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
