import Foundation

public struct CardModel {
    public let id: String
    public let frontText: String
    public let downText: String
    public let guessCounter: Int

    public init(frontText: String, downText: String, guessCounter: Int) {
        self.id = UUID().uuidString
        self.frontText = frontText
        self.downText = downText
        self.guessCounter = guessCounter
    }
}
