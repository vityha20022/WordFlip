import UIKit
import NavigationModule
import MainView
import WordFlipPackage
import Authentication
import Firebase
import FirebaseStorage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        FirebaseApp.configure()
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        guard let window = window else { return }

        coordinator = AppCoordinator(window: window)
        coordinator?.start()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // TODO: delete the method signOut
//        AuthService.shared.signOut { error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//        }
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
