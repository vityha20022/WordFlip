import UIKit
import NavigationModule
import MainView


public protocol RouterProtocol {
    func createTabBar() -> UIViewController
}

public class RouterImp: RouterProtocol {
    public init(){}
    public func createTabBar() -> UIViewController {
        let view = TabBarViewControllerImp(vc: MainViewController())
        let presenter = TabBarPresenterImp(view: view)
        view.presenter = presenter
        return view

    }
}
