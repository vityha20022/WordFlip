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
        let presenter = TabBarPresenter()
        let view = TabBarViewController(decksVC: DecksBuilder(dataManager: entityDataManager).build(), cardsVC: CardsViewController(), userVC: ProfileBuilder().build(), presenter: presenter)
        presenter.view = view
        return view
    }
}
