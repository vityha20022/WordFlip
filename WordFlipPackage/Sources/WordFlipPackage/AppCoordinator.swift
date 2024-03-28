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
        let mainView: UIViewController

        if Auth.auth().currentUser == nil {
            mainView = EnterViewController(nibName: nil, bundle: nil)
        } else {
            mainView = CardsViewController(nibName: nil, bundle: nil)
        }

        navigationController.viewControllers = [mainView]
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
    }

}
