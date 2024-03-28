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

    public func createTabBar(navDelegate: ProfileNavigationProtocol?) -> UIViewController {
        let cardsPresenter = CardsPresenter(dataManager: entityDataManager)
        let cardsView = CardsViewController(presenter: cardsPresenter)

        let presenter = TabBarPresenter()
        let view = TabBarViewController(decksVC: DecksBuilder(dataManager: entityDataManager).build(), cardsVC: cardsView, userVC: ProfileBuilder().build(navDelegate: navDelegate), presenter: presenter)
		presenter.view = view
        
        return view
    }
}
