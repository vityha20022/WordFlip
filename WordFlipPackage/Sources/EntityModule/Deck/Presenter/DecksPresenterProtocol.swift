import UIKit
import Models

protocol DecksPresenterProtocol: AnyObject {
    func getData() -> [DeckModel]
    func didTapDelete(index: Int)
    func didTapEdit(index: Int)
    func didTapAdd()
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
        let deckRedactorConfiguration = DeckRedactorConfiguration(title: "Edit deck")
        decksView?.showDeckRedactor(with: deckRedactorConfiguration, dataManager: dataManager, deckId: model.id)
    }

    func didTapAdd() {
        let deckRedactorConfiguration = DeckRedactorConfiguration(title: "Add deck")
        decksView?.showDeckRedactor(with: deckRedactorConfiguration, dataManager: dataManager, deckId: "")
    }
}
