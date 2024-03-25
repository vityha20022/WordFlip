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
    
    public init(id: String = UUID().uuidString, frontText: String, downText: String) {
        self.id = id
        self.frontText = frontText
        self.downText = downText
    }
}

public struct DeckModel {
    public let id: String
    public let name: String
    public let wordCounter: Int
    public let learnedWordCounter: Int
    public let cards: [CardModel]
    
    public init(id: String = UUID().uuidString, name: String, wordCounter: Int, learnedWordCounter: Int, cards: [CardModel]) {
        self.id = id
        self.name = name
        self.wordCounter = wordCounter
        self.learnedWordCounter = learnedWordCounter
        self.cards = cards
    }
}
