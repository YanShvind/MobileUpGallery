
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let token = MKeychainManager.shared.getToken(withIdentifier: "myToken")
        if token != nil {
            let galleryVC = MGalleryViewController()
            window.rootViewController = UINavigationController(rootViewController: galleryVC)
        } else {
            let vc = MLoginViewController()
            window.rootViewController = vc
        }

        window.makeKeyAndVisible()
        self.window = window
    }
    
    func userVerification() {
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

