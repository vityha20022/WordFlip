import UIKit
import NavigationModule
import MainView
import ProfilePackage
import EntityModule

public class Builder {
    public init() {}
    public func createTabBar() -> UIViewController {
        let taBarPresenter = TabBarPresenter()

        let cardsPresenter = CardsPresenter()
        let cardsView = CardsViewController(presenter: cardsPresenter)

        let view = TabBarViewController(
            decksVC: DecksViewController(),
            cardsVC: cardsView,
            userVC: ProfileBuilder().build(),
            presenter: taBarPresenter
        )
//        cardsPresenter.view = cardsView as! any TabBarViewControllerProtocol
        taBarPresenter.view = view
        return view
    }
}
