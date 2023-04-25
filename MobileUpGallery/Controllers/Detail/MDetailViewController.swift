
import Foundation
import UIKit

final class MDetailViewController: UIViewController {
    
    private let detailView = MDetailView()
    
    init(title: String, imageUrl: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
        self.detailView.configureImage(with: imageUrl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpNavigationItem()
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setUpNavigationItem() {
        let borderView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.size.height ?? 0,
                                              width: navigationController?.navigationBar.frame.size.width ?? 0, height: 1))
        borderView.backgroundColor = .systemGray3
        navigationController?.navigationBar.addSubview(borderView)
        
        let systemImage = UIImage(systemName: "square.and.arrow.up")
        let button = UIBarButtonItem(image: systemImage, style: .plain, target: self, action: #selector(didTapButton))
        button.tintColor = .label
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func didTapButton(_ sender: UIBarButtonItem) {
        let image = detailView.getImage()
        let shareController = UIActivityViewController(activityItems: [image!],
                                                       applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                // save alert
            }
        }
        present(shareController, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
