
import UIKit

// добавление сразу нескольких элементов
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
