import UIKit

public struct ProfileBuilder {
    
    public init() {
    }
    
    public func build() -> UIViewController {
        let presentor = ProfilePresenter()
        let profileViewController = ProfileViewController(presenter: presentor)
        presentor.profileView = profileViewController
        let navigationController = UINavigationController(rootViewController: profileViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
}
