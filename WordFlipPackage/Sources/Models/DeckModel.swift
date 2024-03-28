import Foundation

public struct DeckModel {
    public var id: String
    public var name: String
    public var cards: [CardModel]
    public var wordCounter: Int {
        return cards.count
    }
    public var learnedWordCounter: Int {
        // TODO: Get from app settings
        let successesForRememberCount = 3
        return cards.filter({ $0.guessCounter >= successesForRememberCount }).count
    }

    public init(name: String = "", cards: [CardModel] = []) {
        self.id = UUID().uuidString
        self.name = name
        self.cards = cards
    }
}
