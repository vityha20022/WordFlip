import UIKit
import Models

protocol DeckRedactorPresenterProtocol: AnyObject {
    func getCardsData() -> [CardModel]
    func getDeckData() -> DeckModel
    func didTapDone(deckName: String)
    func didTapDelete(index: Int)
    func didTapEdit(index: Int)
    func didTapAdd()
    func didTapBack()
}

final class DeckRedactorPresenter: DeckRedactorPresenterProtocol {
    private var deckId: String
    private let temporaryDeck: DeckModel
    private var isNewDeck = false

    private let dataManager: EntityDataManager
    weak var deckRedactorView: DeckRedactorViewProtocol?

    init(dataManager: EntityDataManager, deckId: String) {
        self.deckId = deckId
        self.dataManager = dataManager
        
        guard let temporaryDeck = dataManager.getDeck(by: deckId) else {
            isNewDeck = true
            temporaryDeck = DeckModel()
            self.deckId = temporaryDeck.id
            dataManager.addOrUpdateDeck(deckModel: temporaryDeck)
            return
        }
        
        self.temporaryDeck = temporaryDeck
    }

    func getCardsData() -> [CardModel] {
        guard let deck = dataManager.getDeck(by: deckId) else {
            return []
        }

        return deck.cards
    }

    func getDeckData() -> DeckModel {
        guard let deck = dataManager.getDeck(by: deckId) else {
            return DeckModel()
        }

        return deck
    }
    
    func didTapDone(deckName: String) {
        guard !deckName.isEmpty else {
            deckRedactorView?.showWarningAlert(message: "Deck with empty name".localized)
            return
        }
        
        var deck = dataManager.getDeck(by: deckId) ?? DeckModel()
        
        deckId = deck.id
        deck.name = deckName
        
        dataManager.addOrUpdateDeck(deckModel: deck)
        deckRedactorView?.showPreviousController()
    }

    func didTapDelete(index: Int) {
        dataManager.removeCell(cardModel: getCardsData()[index])
        deckRedactorView?.removeCell(at: index)
    }

    func didTapEdit(index: Int) {
        guard let model = dataManager.getDeck(by: deckId)?.cards[index] else {
            return
        }
        
        let cardRedactorConfiguration = CardRedactorConfiguration(title: "EditCard".localized)
        deckRedactorView?.showCardRedactorController(with: cardRedactorConfiguration, dataManager: dataManager, cardId: model.id, deckId: deckId)
    }
    
    func didTapAdd() {
        let cardRedactorConfiguration = CardRedactorConfiguration(title: "AddCard".localized)
        deckRedactorView?.showCardRedactorController(with: cardRedactorConfiguration, dataManager: dataManager, cardId: "", deckId: deckId)
    }
    
    func didTapBack() {
        if isNewDeck {
            dataManager.removeDeck(by: deckId)
        } else {
            dataManager.addOrUpdateDeck(deckModel: temporaryDeck)
        }
    }
}
