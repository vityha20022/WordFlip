import FirebaseAuth
import UIKit
import EntityModule
import Authentication
import MainView

public final class AppCoordinator {

    var window: UIWindow

    public init(window: UIWindow) {
        self.window = window
    }

    public func start() {
        let navigationController = UINavigationController()

        if Auth.auth().currentUser == nil {
            let mainView = EnterViewController(nibName: nil, bundle: nil)
            navigationController.viewControllers = [mainView]
        } else {
            let mainView = CardsViewController(nibName: nil, bundle: nil)
            navigationController.viewControllers = [mainView]
        }

        window.makeKeyAndVisible()
        window.rootViewController = navigationController
    }

}
