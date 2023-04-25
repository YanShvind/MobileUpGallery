
import UIKit

final class MGalleryViewController: UIViewController {
    
    private let galleryView = MGalleryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponents()
        setUpView()
    }
    
    private func setUpComponents() {
        title = "MobileUp Gallery"
        view.backgroundColor = .systemBackground
        
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
        
    @objc private func exitButtonTapped() {
        MKeychainManager.shared.deleteToken(withIdentifier: "myToken")
        MDataManager.shared.clearningCookies()
        
        let vc = MLoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
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
