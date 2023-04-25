
import UIKit

protocol MGalleryViewDelegate: AnyObject {
    func mGalleryView(_ galleryView: MGalleryView,
                      didSelectImage image: MImageDataModel)
}

final class MGalleryView: UIView {
    
    weak var delegate: MGalleryViewDelegate?
    private let viewModel = MGalleryViewViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 3
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MGalleryCollectionViewCell.self,
                                forCellWithReuseIdentifier: MGalleryCollectionViewCell.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        viewModel.fetchImages()
        viewModel.delegate = self
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        addSubview(collectionView)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MGalleryView: MGalleryViewViewModelDelegate {
    func didSelectImage(_ image: MImageDataModel) {
        delegate?.mGalleryView(self, didSelectImage: image)
    }
    
    func onCollectionUpdate() {
        self.collectionView.reloadData()
    }
}
