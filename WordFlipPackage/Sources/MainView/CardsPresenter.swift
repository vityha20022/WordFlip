import Foundation
import Models

public enum SwipeDirection {
    case right, left
}

public protocol CardsPresenterProtocol: AnyObject {
    var model: DeckModel? { get }
    func handleCardSwipe(at card: CardModel, to direction: SwipeDirection)
}

public class CardsPresenter: CardsPresenterProtocol {
    public var model: DeckModel?
    private weak var view: CardsPresenterProtocol?

    public init() {
        model = nil
//        model = DeckModel(
//            name: "Животные",
//            wordCounter: 36,
//            learnedWordCounter: 2,
//            cards: [
//                CardModel(frontText: "Animal", downText: "Жывотнае", guessCounter: 1),
//                CardModel(frontText: "Dog", downText: "Собаке", guessCounter: 1),
//                CardModel(frontText: "Cat", downText: "Кошкотакбас", guessCounter: 1),
//                CardModel(frontText: "Bat", downText: "Man", guessCounter: 1),
//                CardModel(frontText: "Elephant", downText: "Слоняра", guessCounter: 1),
//                CardModel(frontText: "Chicken", downText: "И картофель фри пожалуйста", guessCounter: 1),
//                CardModel(frontText: "Animal", downText: "Жывотнае", guessCounter: 1),
//                CardModel(frontText: "Dog", downText: "Собаке", guessCounter: 1),
//                CardModel(frontText: "Cat", downText: "Кошкотакбас", guessCounter: 1),
//                CardModel(frontText: "Bat", downText: "Man", guessCounter: 1),
//                CardModel(frontText: "Elephant", downText: "Слоняра", guessCounter: 1),
//                CardModel(frontText: "Chicken", downText: "И картофель фри пожалуйста", guessCounter: 1),
//                CardModel(frontText: "Animal", downText: "Жывотнае", guessCounter: 1),
//                CardModel(frontText: "Dog", downText: "Собаке", guessCounter: 1),
//                CardModel(frontText: "Cat", downText: "Кошкотакбас", guessCounter: 1),
//                CardModel(frontText: "Bat", downText: "Man", guessCounter: 1),
//                CardModel(frontText: "Elephant", downText: "Слоняра", guessCounter: 1),
//                CardModel(frontText: "Chicken", downText: "И картофель фри пожалуйста", guessCounter: 1),
//                CardModel(frontText: "Animal", downText: "Жывотнае", guessCounter: 1),
//                CardModel(frontText: "Dog", downText: "Собаке", guessCounter: 1),
//                CardModel(frontText: "Cat", downText: "Кошкотакбас", guessCounter: 1),
//                CardModel(frontText: "Bat", downText: "Man", guessCounter: 1),
//                CardModel(frontText: "Elephant", downText: "Слоняра", guessCounter: 1),
//                CardModel(frontText: "Chicken", downText: "И картофель фри пожалуйста", guessCounter: 1),
//                CardModel(frontText: "Animal", downText: "Жывотнае", guessCounter: 1),
//                CardModel(frontText: "Dog", downText: "Собаке", guessCounter: 1),
//                CardModel(frontText: "Cat", downText: "Кошкотакбас", guessCounter: 1),
//                CardModel(frontText: "Bat", downText: "Man", guessCounter: 1),
//                CardModel(frontText: "Elephant", downText: "Слоняра", guessCounter: 1),
//                CardModel(frontText: "Chicken", downText: "И картофель фри пожалуйста", guessCounter: 1),
//                CardModel(frontText: "Animal", downText: "Жывотнае", guessCounter: 1),
//                CardModel(frontText: "Dog", downText: "Собаке", guessCounter: 1),
//                CardModel(frontText: "Cat", downText: "Кошкотакбас", guessCounter: 1),
//                CardModel(frontText: "Bat", downText: "Man", guessCounter: 1),
//                CardModel(frontText: "Elephant", downText: "Слоняра", guessCounter: 1),
//                CardModel(frontText: "Chicken", downText: "И картофель фри пожалуйста", guessCounter: 1),
//            ])
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
}
