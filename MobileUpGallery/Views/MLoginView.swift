
import Foundation
import UIKit

final class MLoginView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var viewModel: MLoginViewViewModel? {
        didSet {
            titleLabel.text = viewModel?.titleText
            loginButton.setTitle(viewModel?.buttonText, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        
        addSubviews(titleLabel, loginButton)
        addConstraints()
    }
    
    @objc
    private func loginButtonTapped() {
        viewModel?.loginButtonTapped()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 170),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            titleLabel.heightAnchor.constraint(equalToConstant: 150),
            
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -42),
            loginButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
