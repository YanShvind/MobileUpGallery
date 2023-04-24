
import Foundation

protocol MLoginViewViewModelDelegate: AnyObject {
    func loginViewDidTapButton()
}

final class MLoginViewViewModel: NSObject {
    
    weak var delegate: MLoginViewViewModelDelegate?
    
    let titleText: String
    let buttonText: String
    
    override init() {
        titleText = "Mobile Up\nGallery"
        buttonText = "Вход через VK"
    }
    
    func loginButtonTapped() {
        delegate?.loginViewDidTapButton()
    }
}
