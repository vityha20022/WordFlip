//
//  File.swift
//  
//
//  Created by Виктор Борисовский on 25.03.2024.
//

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
