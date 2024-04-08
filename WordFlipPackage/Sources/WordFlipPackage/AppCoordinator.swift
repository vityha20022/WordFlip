import FirebaseAuth
import UIKit
import EntityModule
import Authentication
import MainView
import Builder
import ProfilePackage

public final class AppCoordinator: NavigationProtocol, ProfileNavigationProtocol  {

    var window: UIWindow

    public init(window: UIWindow) {
        self.window = window
    }

    public func start() {
        let mainView: UIViewController

        if Auth.auth().currentUser == nil {
            mainView = UINavigationController(rootViewController: EnterBuilder().build(navDelegate: self))
        } else {
            mainView = Builder(entityDataManager: EntityDataManager()).createTabBar(navDelegate: self)
        }

        window.rootViewController = mainView
        window.makeKeyAndVisible()
    }
    
    public func goToMainView() {
        let vc = Builder(entityDataManager: EntityDataManager()).createTabBar(navDelegate: self)
        setRootViewController(vc)
    }
    
    public func goToEnterScreen() {
        let vc = UINavigationController(rootViewController: EnterBuilder().build(navDelegate: self))
        setRootViewController(vc)
    }
    
    private func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }

}
