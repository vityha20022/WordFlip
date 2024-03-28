import Foundation

public struct CardModel {
    public var id: String
    public var frontText: String
    public var downText: String
    public var guessCounter: Int

    public init(frontText: String, downText: String, guessCounter: Int) {
        self.id = UUID().uuidString
        self.frontText = frontText
        self.downText = downText
        self.guessCounter = guessCounter
    }
}
