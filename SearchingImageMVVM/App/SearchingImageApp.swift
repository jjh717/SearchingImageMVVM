import SwiftUI

@main
struct SearchingImageApp: App {

    /// true = SwiftUI, false = UIKit
    private let useSwiftUI = true

    var body: some Scene {
        WindowGroup {
            if useSwiftUI {
                ImageGridView()
            } else {
                UIKitSearchView()
            }
        }
    }
}

// MARK: - UIKit Wrapper

struct UIKitSearchView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: SearchViewController())
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
