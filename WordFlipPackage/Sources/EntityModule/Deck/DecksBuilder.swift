import UIKit

public struct DecksBuilder {
    private let dataManager: EntityDataManager

    public init(dataManager: EntityDataManager) {
        self.dataManager = dataManager
    }

    public func build() -> UIViewController {
        let presenter = DecksPrersenter(dataManager: dataManager)
        let decksViewController = DecksViewController(presenter: presenter)
        presenter.decksView = decksViewController
        let navigationController = UINavigationController(rootViewController: decksViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
}
