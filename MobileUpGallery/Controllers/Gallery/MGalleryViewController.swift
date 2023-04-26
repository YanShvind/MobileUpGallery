
import UIKit

final class MGalleryViewController: MConnectivityViewController {
    
    private let galleryView = MGalleryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponents()
        setUpView()
    }
    
    private func setUpComponents() {
        title = "MobileUp Gallery"
        view.backgroundColor = .systemBackground
        galleryView.delegate = self
                
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        let titleFont = UIFont.boldSystemFont(ofSize: 17)
        navigationBar.titleTextAttributes = [.font: titleFont]
        
        let exitButton = UIBarButtonItem(title: "Выход",
                                         style: .done,
                                         target: self,
                                         action: #selector(exitButtonTapped))
        exitButton.tintColor = .label
        navigationItem.rightBarButtonItem = exitButton
        
        let buttonFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        exitButton.setTitleTextAttributes([.font: buttonFont], for: .normal)
    }
    
    @objc
    private func exitButtonTapped() {
        
        let alert = UIAlertController(title: nil, message: "Вы действительно хотите выйти?", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        let exitAction = UIAlertAction(title: "Выйти", style: .destructive) { _ in
            MKeychainManager.shared.deleteToken(withIdentifier: "myToken")
            MCookiesManager.shared.clearningCookies()
            
            let vc = MLoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.dismiss(animated: true) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        alert.addAction(exitAction)

        present(alert, animated: true, completion: nil)
    }
    
    private func setUpView() {
        view.addSubview(galleryView)
        NSLayoutConstraint.activate([
            galleryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            galleryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            galleryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            galleryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension MGalleryViewController: MGalleryViewDelegate {
    func mGalleryView(_ galleryView: MGalleryView, didSelectImage image: MImageDataModel, images: [MImageDataModel]) {
        let date = Date(timeIntervalSince1970: TimeInterval(image.date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: date)
        let urlString = image.urlString
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .label
        self.navigationItem.backBarButtonItem = backButton
        let detailVC = MDetailViewController(title: dateString, imageUrl: urlString, images: images)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
