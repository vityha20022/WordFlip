import UIKit

public struct CardRedactorBuilder {
    private let dataManager: EntityDataManager
    private let cardConfiguration: CardRedactorConfiguration
    private let cardId: String
    private let deckId: String

    public init(dataManager: EntityDataManager, configuration: CardRedactorConfiguration, cardId: String, deckId: String) {
        self.dataManager = dataManager
        self.cardConfiguration = configuration
        self.cardId = cardId
        self.deckId = deckId
    }

    public func build() -> UIViewController {
        let presenter = CardRedactorPresenter(dataManager: dataManager, cardId: cardId, deckId: deckId)
        let cardRedactorViewController = CardRedactorViewController(presenter: presenter, configuration: cardConfiguration)
        presenter.cardRedactorView = cardRedactorViewController
        return cardRedactorViewController
    }
}
