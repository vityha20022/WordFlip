import UIKit

public struct EnterBuilder {
    
    public init() {}

    public func build(navDelegate: NavigationProtocol?) -> UIViewController {
        let presenter = EnterScreenPresenter(delegate: navDelegate)
        let enterVC = EnterViewController(presenter: presenter)
        presenter.viewController = enterVC
        return enterVC
    }
}
