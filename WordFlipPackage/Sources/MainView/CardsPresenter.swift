import Foundation
import Models
import EntityModule

public enum SwipeDirection {
    case right, left
}

public protocol CardsPresenterProtocol: AnyObject {
    var model: DeckModel? { get }
    func handleCardSwipe(at card: CardModel, to direction: SwipeDirection)
    func getDeck() -> DeckModel?
    func saveCard(cardModel: CardModel)
}

public class CardsPresenter: CardsPresenterProtocol {
    public func getDeck() -> DeckModel?{
        guard let deck = dataManager.getCurrentDeck() else {return nil}
        return deck
    }

    private var dataManager: EntityDataManager
    public var model: DeckModel?
    private weak var view: CardsPresenterProtocol?

    public init(dataManager: EntityDataManager) {
        self.dataManager = dataManager
        
    }

    public func handleCardSwipe(at card: CardModel, to direction: SwipeDirection) {
    }
    
    public func saveCard(cardModel: CardModel) {
        dataManager.addOrUpdateCard(cardModel: cardModel)
    }
}
