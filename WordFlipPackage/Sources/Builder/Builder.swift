import UIKit
import NavigationModule
import MainView
import ProfilePackage
import EntityModule

public class Builder {
    private let entityDataManager: EntityDataManager

    public init(entityDataManager: EntityDataManager) {
        self.entityDataManager = entityDataManager
    }

    public func createTabBar() -> UIViewController {
        let cardsPresenter = CardsPresenter()
        let cardsView = CardsViewController(presenter: cardsPresenter)

        let view = TabBarViewController(decksVC: DecksBuilder(dataManager: entityDataManager).build(), cardsVC: cardsView, userVC: ProfileBuilder().build(navDelegate: navDelegate), presenter: presenter)
        let presenter = TabBarPresenter()
		presenter.view = view
        return view
    }
}
