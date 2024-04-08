import UIKit
import Authentication

public struct ProfileBuilder {

    public init() {}

    public func build(navDelegate: ProfileNavigationProtocol?) -> UIViewController {
        let presentor = ProfilePresenter(delegate: navDelegate)
        let profileViewController = ProfileViewController(presenter: presentor)
        presentor.profileView = profileViewController
        let navigationController = UINavigationController(rootViewController: profileViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
}
