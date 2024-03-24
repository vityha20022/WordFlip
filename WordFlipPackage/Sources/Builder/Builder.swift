import UIKit
import NavigationModule
import MainView
import ProfilePackage

public class Builder {
    public init(){}
    public func createTabBar() -> UIViewController {
        let view = TabBarViewController(decksVC: UIViewController(), cardsVC: CardsViewController(), userVC: ProfileViewController())
        let presenter = TabBarPresenter(view: view)
        view.get(presenter: presenter)
        return view
    }
}
