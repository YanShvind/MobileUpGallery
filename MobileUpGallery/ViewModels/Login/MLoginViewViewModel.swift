
import Foundation

protocol MLoginViewViewModelDelegate: AnyObject {
    func loginViewDidTapButton()
}

final class MLoginViewViewModel: NSObject {
    
    static let shared = MLoginViewViewModel()
    
    weak var delegate: MLoginViewViewModelDelegate?
    
    var userLoggedIn = false
    
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
