import UIKit

public struct RegisterBuilder {

    public init() {}

    public func build(navDelegate: NavigationProtocol?) -> UIViewController {
        let presenter = RegisterScreenPresenter(delegate: navDelegate)
        let registerVC = RegisterViewController(presenter: presenter)
        presenter.viewController = registerVC
        return registerVC
    }
}
