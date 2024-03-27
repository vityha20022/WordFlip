import FirebaseAuth
import UIKit
import EntityModule
import Authentication
import MainView

public class AppCoordinator {
    
    var window: UIWindow
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        if Auth.auth().currentUser == nil {
            let nav = UINavigationController()
            let mainView = EnterViewController(nibName: nil, bundle: nil)
            nav.viewControllers = [mainView]
            window.makeKeyAndVisible()
            window.rootViewController = nav
        } else {
            let mainView = CardsViewController(nibName: nil, bundle: nil)
            let nav = UINavigationController()
            nav.viewControllers = [mainView]
            window.makeKeyAndVisible()
            window.rootViewController = nav
        }
    }
    
}


