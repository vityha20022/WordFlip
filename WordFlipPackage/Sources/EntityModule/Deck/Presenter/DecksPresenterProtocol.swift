import UIKit
import Models

protocol DecksPresenterProtocol: AnyObject {
    func getData() -> [DeckModel]
    func didTapDelete(index: Int)
    func didTapEdit(index: Int)
    func didTapAdd()
    func didTapCell(index: Int)
}

final class DecksPrersenter: DecksPresenterProtocol {
    private let dataManager: EntityDataManager
    weak var decksView: DecksViewProtocol?

    init(dataManager: EntityDataManager) {
        self.dataManager = dataManager
    }

    func getData() -> [DeckModel] {
        return dataManager.getDecks()
    }

    func didTapDelete(index: Int) {
        dataManager.removeDeck(at: index)
        decksView?.removeCell(at: index)
    }

    func didTapEdit(index: Int) {
        let model = dataManager.getDecks()[index]
        let deckRedactorConfiguration = DeckRedactorConfiguration(title: "Edit Deck".localized)
        decksView?.showDeckRedactor(with: deckRedactorConfiguration, dataManager: dataManager, deckId: model.id)
    }

    func didTapAdd() {
        let deckRedactorConfiguration = DeckRedactorConfiguration(title: "AddDeck".localized)
        decksView?.showDeckRedactor(with: deckRedactorConfiguration, dataManager: dataManager, deckId: "")
    }
    
    func didTapCell(index: Int) {
        dataManager.changeCurrentDeck(index: index)
        NotificationCenter.default.post(name: .onDeckChange, object: nil)
    }
}
