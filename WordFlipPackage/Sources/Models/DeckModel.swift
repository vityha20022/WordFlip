import Foundation

public struct DeckModel {
    public let id: String
    public let name: String
    public let wordCounter: Int
    public let learnedWordCounter: Int
    public let cards: [CardModel]
    
    public init(name: String, wordCounter: Int, learnedWordCounter: Int, cards: [CardModel]) {
        self.id = UUID().uuidString
        self.name = name
        self.wordCounter = wordCounter
        self.learnedWordCounter = learnedWordCounter
        self.cards = cards
    }
}
