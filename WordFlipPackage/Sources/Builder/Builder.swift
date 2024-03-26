import UIKit
import NavigationModule
import MainView
import ProfilePackage
import EntityModule

public class Builder {
    public init(){}
    public func createTabBar() -> UIViewController {
        let presenter = TabBarPresenter()
        let view = TabBarViewController(decksVC: DecksViewController(), cardsVC: CardsViewController(), userVC: ProfileBuilder().build(), presenter: presenter)
        presenter.view = view
        return view
    }
}
