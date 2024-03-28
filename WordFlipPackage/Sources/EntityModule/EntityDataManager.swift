import Foundation
import Models



public final class EntityDataManager {
    private var decks: [DeckModel]
    private var currentDeckId: String = ""

    public init() {
        // TODO: Get decks from firebase
        decks = []
        for i in 0...5 {
            var deck = DeckModel(name: String(repeating: "A", count: Int.random(in: 0...100)), cards: [])
            for i in 0...1 {
                deck.cards.append(CardModel(deckId: deck.id, frontText: String(repeating: "A", count: Int.random(in: 0...100)), downText: String(repeating: "A", count: Int.random(in: 0...100)), guessCounter: 10))
                deck.cards.append(CardModel(deckId: deck.id, frontText: String(repeating: "A", count: Int.random(in: 0...100)), downText: String(repeating: "A", count: Int.random(in: 0...100)), guessCounter: 1))
            }
            decks.append(deck)
        }
        
        /*var firstDeck = DeckModel(name: "Animals", cards: [])
        firstDeck.cards.append(CardModel(deckId: firstDeck.id, frontText: "Cat", downText: "Dog", guessCounter: 10))
        firstDeck.cards.append(CardModel(deckId: firstDeck.id, frontText: "Mouse", downText: "Elephant", guessCounter: 1))

        var secondDeck = DeckModel(name: "Cars", cards: [])
        secondDeck.cards.append(CardModel(deckId: secondDeck.id, frontText: "Ferrari", downText: "Italian", guessCounter: 5))
        secondDeck.cards.append(CardModel(deckId: secondDeck.id, frontText: "Germany", downText: "BMW", guessCounter: 7))

        decks = [firstDeck, secondDeck]*/
    }

    public func getDeck(by id: String) -> DeckModel? {
        return decks.first(where: { $0.id == id })
    }
    
    public func getCard(by id: String) -> CardModel? {
        for deck in decks {
            if let card = deck.cards.first(where: { $0.id == id}) {
                return card
            }
        }
        
        return nil
    }

    public func getDecks() -> [DeckModel] {
        return decks
    }

    public func removeDeck(at index: Int) {
        decks.remove(at: index)
        save()
    }
    
    public func removeDeck(by id: String) {
        decks.removeAll(where: { $0.id == id })
    }
    
    public func removeCell(cardModel: CardModel) {
        guard let deckIndex = decks.firstIndex(where: { $0.id == cardModel.deckId }) else {
            return
        }
        
        decks[deckIndex].cards.removeAll { $0.id == cardModel.id }
        save()
    }
    
    public func addOrUpdateDeck(deckModel: DeckModel) {
        defer {
            save()
        }
        
        guard let deckIndex = decks.firstIndex(where: { $0.id == deckModel.id }) else {
            decks.append(deckModel)
            return
        }
        
        decks[deckIndex] = deckModel
    }
    
    public func addOrUpdateCard(cardModel: CardModel) {
        defer {
            save()
        }
        
        guard let deckIndex = decks.firstIndex(where: { $0.id == cardModel.deckId }) else {
            return
        }
        
        guard let cardIndex = decks[deckIndex].cards.firstIndex(where: { $0.id == cardModel.id }) else {
            decks[deckIndex].cards.append(cardModel)
            return
        }
        
        decks[deckIndex].cards[cardIndex] = cardModel
    }

    public func save() {
        // TODO: Save state in firebase
    }
    
    public func changeCurrentDeck(index: Int) {
        currentDeckId = decks[index].id
    }
    
    public func getCurrentDeck() -> DeckModel? {
        return decks.first(where: { $0.id == currentDeckId })
    }
}



extension NSNotification.Name {
    static let onDeckChange = Notification.Name("on-deck-change")
}
