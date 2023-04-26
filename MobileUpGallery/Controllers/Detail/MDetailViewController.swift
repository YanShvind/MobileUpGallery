
import Foundation
import UIKit

final class MDetailViewController: MConnectivityViewController {
    
    private let detailView = MDetailView()
    private var images = [MImageDataModel]()
    
    init(title: String, imageUrl: String, images: [MImageDataModel]) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
        self.detailView.configureImage(with: imageUrl)
        self.images = images
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        detailView.collectionView.delegate = self
        detailView.collectionView.dataSource = self
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
        let button = UIBarButtonItem(image: systemImage,
                                     style: .plain,
                                     target: self,
                                     action: #selector(didTapButton))
        button.tintColor = .label
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func didTapButton(_ sender: UIBarButtonItem) {
        let image = detailView.getImage()
        let shareController = UIActivityViewController(activityItems: [image!],
                                                       applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                UIAlertController.showAlert(title: "Операция выполнена успешно",
                                            message: nil,
                                            viewController: self)
            } else {
                UIAlertController.showAlert(title: "Упс...",
                                            message: "Вы закрыли окно",
                                            viewController: self)
            }
        }
        
        present(shareController, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MDetailCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? MDetailCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        let imageURL = images[indexPath.row].urlString
        cell.configure(with: imageURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let image = images[indexPath.row].urlString
        detailView.configureImage(with: image)
        let date = Date(timeIntervalSince1970: TimeInterval(images[indexPath.row].date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: date)
        title = dateString
    }
}
