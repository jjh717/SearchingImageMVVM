import UIKit
import Combine

final class SearchViewController: UIViewController {

    private let viewModel = SearchViewModelUIKit()

    private lazy var layout: PinterestCollectionViewLayout = {
        let layout = PinterestCollectionViewLayout()
        layout.delegate = self
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        cv.delegate = self
        cv.backgroundColor = .systemBackground
        return cv
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, UnsplashPhoto> = {
        UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, photo in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as! ImageCell
            cell.configure(with: photo.urls.small)
            return cell
        }
    }()

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Unsplash"
        navigationController?.navigationBar.prefersLargeTitles = false
        setupCollectionView()
        bindViewModel()

        Task { await viewModel.loadInitial() }
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.$photos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] photos in
                self?.applySnapshot(photos)
            }
            .store(in: &cancellables)
    }

    private func applySnapshot(_ photos: [UnsplashPhoto]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UnsplashPhoto>()
        snapshot.appendSections([0])
        snapshot.appendItems(photos)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height

        if contentHeight > 0, offsetY + frameHeight > contentHeight - 100 {
            Task { await viewModel.loadMore() }
        }
    }
}

// MARK: - PinterestCollectionViewLayoutDelegate

extension SearchViewController: PinterestCollectionViewLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, width: CGFloat) -> CGFloat {
        let photo = viewModel.photos[indexPath.item]
        return CGFloat(photo.height) * width / CGFloat(photo.width)
    }
}
