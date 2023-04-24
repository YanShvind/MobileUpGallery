
import UIKit

final class MLoginViewController: UIViewController {
    
    private let loginView = MLoginView()
    private let viewModel = MLoginViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setUpView()
        viewModel.delegate = self
        bindViewModel()
    }
    
    private func setUpView() {
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func bindViewModel() {
        loginView.viewModel = viewModel
    }
}

extension MLoginViewController: MLoginViewViewModelDelegate {
    func loginViewDidTapButton() {
        let authorizationVC = MAuthorizationViewController()
        let navigationController = UINavigationController(rootViewController: authorizationVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}
