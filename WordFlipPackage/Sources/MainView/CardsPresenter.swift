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

    //TODO: - Обработка смахивания карты
    public func handleCardSwipe(at card: CardModel, to direction: SwipeDirection) {
        // например, если карта смахнута вправо, увеличиваем счетчик угаданных слов
        //        if direction == .right {
        //            model.cards[index].guessCounter += 1
        //        } else if direction == .left {
        //            model.cards[index].guessCounter = 0
        //        }
//    }

        if card.guessCounter > 5 {
            // TODO: - Удаляем смахнутую карту из модели
            // model.cards.remove(at: index)
        }
    }
    
    public func saveCard(cardModel: CardModel) {
        dataManager.addOrUpdateCard(cardModel: cardModel)
    }
}
