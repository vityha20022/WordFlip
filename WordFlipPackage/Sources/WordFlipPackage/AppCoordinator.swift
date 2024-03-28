import FirebaseAuth
import UIKit
import EntityModule
import Authentication
import MainView
import Builder

public final class AppCoordinator: NavigationProtocol {

    var window: UIWindow

    public init(window: UIWindow) {
        self.window = window
    }

    public func start() {
        let navigationController = UINavigationController()
        let mainView: UIViewController

        if Auth.auth().currentUser == nil {
            mainView = EnterBuilder().build(navDelegate: self)
        } else {
            mainView = Builder(entityDataManager: EntityDataManager()).createTabBar()
        }

        navigationController.viewControllers = [mainView]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    public func goToMainView() {
        window.rootViewController = Builder(entityDataManager: EntityDataManager()).createTabBar()
    }

}
