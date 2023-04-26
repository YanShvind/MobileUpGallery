
import UIKit

// добавление сразу нескольких элементов
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

// обработчик ошибок
enum APIError: Error {
    case failedToGetData
    case invalidURL
}

// расширение для получения картинки
extension UIImageView {
    func configureImage(with imageURL: String, spinner: UIActivityIndicatorView? = nil) {
        guard let url = URL(string: imageURL) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
                spinner?.stopAnimating()
            }
        }
        task.resume()
    }
}

// алерт
extension UIAlertController {
    static func showAlert(title: String?, message: String?, viewController: UIViewController) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
