
import UIKit
import WebKit

final class MAuthorizationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        makeurlComponents()
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func makeurlComponents() {
        var urlComponents = URLComponents()
        
        let webView = WKWebView()
        view = webView
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true

        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "51624709"),
            URLQueryItem(name: "redirect_url", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token"),
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
    
    @objc private func backButtonPressed() {
        if let webview = view as? WKWebView , webview.canGoBack {
            webview.goBack()
        } else {
            dismiss(animated: true)
            showAlert()
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: nil,
                                                message: "Вы закрыли окно регистрации",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default,
                                                handler: nil))
        
        view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension MAuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }

        let params = fragment.components(separatedBy: "&")
            .map {$0.components(separatedBy: "=")}
            .reduce([String: String]()) { res, param in
                var dict = res
                let key = param[0]
                let value = param[1]
                dict[key] = value

                return dict
            }

        if let accessToken = params["access_token"] {
            MKeychainManager.shared.saveToken(token: accessToken)
            let galleryVC = MGalleryViewController()
            navigationController?.setViewControllers([galleryVC], animated: true)
        } else {
            dismiss(animated: true)
            showAlert()
        }
        decisionHandler(.cancel)
    }
}
