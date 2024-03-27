import UIKit

public struct RegisterBuilder {

    public init() {}

    public func build() -> UIViewController {
        let presenter = RegisterScreenPresenter()
        let registerVC = RegisterViewController(presenter: presenter)
        presenter.viewController = registerVC
        return registerVC
    }
}
