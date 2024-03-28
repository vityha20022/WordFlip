import UIKit

public struct AuthBuilder {

    public init() {}

    public func build(navDelegate: NavigationProtocol?) -> UIViewController {
        let presenter = AuthScreenPresenter(delegate: navDelegate )
        let authVC = AuthViewController(presenter: presenter)
        presenter.viewController = authVC
        return authVC
    }
}
