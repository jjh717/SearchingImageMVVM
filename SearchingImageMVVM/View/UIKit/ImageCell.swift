import UIKit

final class ImageCell: UICollectionViewCell {

    static let reuseIdentifier = "ImageCell"

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemGray6
        return iv
    }()

    private var currentURL: URL?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        currentURL = nil
    }

    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        currentURL = url

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard currentURL == url else { return }
                if let image = UIImage(data: data) {
                    imageView.image = image
                }
            } catch {
                // 이미지 로딩 실패 시 placeholder 유지
            }
        }
    }
}
