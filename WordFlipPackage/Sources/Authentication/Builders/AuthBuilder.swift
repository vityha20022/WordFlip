import UIKit

public struct AuthBuilder {

    public init() {}

    public func build() -> UIViewController {
        let presenter = AuthScreenPresenter()
        let authVC = AuthViewController(presenter: presenter)
        presenter.viewController = authVC
        return authVC
    }
}
