
import Foundation

final class MLoginViewViewModel {
    
    let titleText: String
    let buttonText: String
    
    init() {
        titleText = "Mobile Up\nGallery"
        buttonText = "Вход через VK"
    }
    
    func loginButtonTapped() {
        print("Вход через VK")
    }
}
