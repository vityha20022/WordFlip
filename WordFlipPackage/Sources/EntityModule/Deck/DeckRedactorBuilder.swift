import UIKit

public struct DeckRedactorBuilder {
    private let dataManager: EntityDataManager
    private let deckConfiguration: DeckRedactorConfiguration
    private let deckId: String

    public init(dataManager: EntityDataManager, configuration: DeckRedactorConfiguration, deckId: String) {
        self.dataManager = dataManager
        self.deckConfiguration = configuration
        self.deckId = deckId
    }

    public func build() -> UIViewController {
        let presenter = DeckRedactorPresenter(dataManager: dataManager, deckId: deckId)
        let deckRedactorViewController = DeckRedactorViewController(presenter: presenter, configuration: deckConfiguration)
        presenter.deckRedactorView = deckRedactorViewController
        return deckRedactorViewController
    }
}
