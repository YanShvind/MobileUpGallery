
import Foundation
import UIKit

protocol MGalleryViewViewModelDelegate: AnyObject {
    func onCollectionUpdate()
    func didSelectImage(_ image: MImageDataModel)
}

final class MGalleryViewViewModel: NSObject {
    
    weak var delegate: MGalleryViewViewModelDelegate?
    
    private var images = [MImageDataModel]()
    
    public func fetchImages() {
        MNetworkManager.shared.getImages { [weak self] result in
            switch result {
            case .success(let images):
                DispatchQueue.main.async {
                    self?.images = images
                    self?.delegate?.onCollectionUpdate()
                }
            case .failure:
                print("ERROR")
            }
        }
    }
}

extension MGalleryViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MGalleryCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? MGalleryCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        cell.spinnerAnimating()
        let imageURL = images[indexPath.row].urlString
        cell.configure(with: imageURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let image = images[indexPath.row]
        delegate?.didSelectImage(image)
    }
}
