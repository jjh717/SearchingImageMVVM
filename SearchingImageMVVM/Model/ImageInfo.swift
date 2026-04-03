import Foundation

struct UnsplashPhoto: Decodable, Identifiable {
    let id: String
    let width: Int
    let height: Int
    let urls: URLs

    struct URLs: Decodable {
        let thumb: String
        let small: String
    }

    var aspectRatio: CGFloat {
        guard width > 0 else { return 1 }
        return CGFloat(height) / CGFloat(width)
    }
}
