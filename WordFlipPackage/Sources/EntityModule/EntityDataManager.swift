import Foundation
import Models

public final class EntityDataManager {
    private var decks: [DeckModel] = []
    private var currentDeckId: String = ""
    
    public init() {
        if let savedData = UserDefaults.standard.data(forKey: "DataDecks") {
            let decoder = JSONDecoder()
            if let loadedDecks = try? decoder.decode([DeckModel].self, from: savedData) {
                self.decks = loadedDecks
            }
        }
        
        if let savedDeckId = UserDefaults.standard.string(forKey: "CurrentDeckId") {
            currentDeckId = savedDeckId
        } else {
            currentDeckId = decks.first?.id ?? ""
        }
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
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(decks) {
            UserDefaults.standard.set(encoded, forKey: "DataDecks")
        }
    }
    
    public func changeCurrentDeck(index: Int) {
        currentDeckId = decks[index].id
        UserDefaults.standard.set(currentDeckId, forKey: "CurrentDeckId")
    }
    
    public func getCurrentDeck() -> DeckModel? {
        return decks.first(where: { $0.id == currentDeckId })
    }
}



extension NSNotification.Name {
    static let onDeckChange = Notification.Name("on-deck-change")
}
