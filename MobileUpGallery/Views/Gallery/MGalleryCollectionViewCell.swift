
import UIKit

final class MGalleryCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "MGalleryCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
