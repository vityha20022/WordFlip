import Foundation

public struct CardModel {
    public var id: String
    public var deckId: String
    public var frontText: String
    public var downText: String
    public var guessCounter: Int

    public init(deckId: String, frontText: String = "", downText: String = "", guessCounter: Int = 0) {
        self.id = UUID().uuidString
        self.deckId = deckId
        self.frontText = frontText
        self.downText = downText
        self.guessCounter = guessCounter
    }
}
