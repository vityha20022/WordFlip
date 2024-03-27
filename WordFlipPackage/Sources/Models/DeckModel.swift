import Foundation

public struct DeckModel {
    public var id: String
    public var name: String
    public var wordCounter: Int
    public var learnedWordCounter: Int
    public var cards: [CardModel]

    public init(name: String = "", wordCounter: Int = 0, learnedWordCounter: Int = 0, cards: [CardModel] = []) {
        self.id = UUID().uuidString
        self.name = name
        self.wordCounter = wordCounter
        self.learnedWordCounter = learnedWordCounter
        self.cards = cards
    }
}
