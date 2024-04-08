import UIKit
import Models

protocol CardRedactorPresenterProtocol: AnyObject {
    func getCardData() -> CardModel
    func didTapDone(frontSideText: String, downSideText: String)
    func didTapTranslate(sourceLanguage: Language?, targetLanguage: Language?, text: String)
}

final class CardRedactorPresenter: CardRedactorPresenterProtocol {
    private let cardId: String
    private let deckId: String

    private let dataManager: EntityDataManager
    private let translateManager: TranslateManager
    weak var cardRedactorView: CardRedactorViewProtocol?

    init(dataManager: EntityDataManager, cardId: String, deckId: String) {
        self.cardId = cardId
        self.deckId = deckId
        self.dataManager = dataManager
        self.translateManager = TranslateManager(apiKey: "")
    }

    func getCardData() -> CardModel {
        guard let card = dataManager.getCard(by: cardId) else {
            return CardModel(deckId: deckId)
        }

        return card
    }
    
    func didTapDone(frontSideText: String, downSideText: String) {
        guard !frontSideText.isEmpty, !downSideText.isEmpty else {
            cardRedactorView?.showWarningAlert(title: "Emptycardfield".localized , message: "Cardwithemptyfields".localized)
            return
        }
        
        var card = dataManager.getCard(by: cardId) ?? CardModel(deckId: deckId)
        card.frontText = frontSideText
        card.downText = downSideText
        
        dataManager.addOrUpdateCard(cardModel: card)
        cardRedactorView?.showPreviousController()
    }
    
    func didTapTranslate(sourceLanguage: Language?, targetLanguage: Language?, text: String) {
        guard let sourceLanguage = sourceLanguage, let targetLanguage = targetLanguage else {
            return
        }
        
        translateManager.translate(endpoint: .translate(text: text, source: sourceLanguage, target: targetLanguage, key: translateManager.apiKey)) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
                case .success(let translatedText):
                    var card = self.getCardData()
                    card.downText = translatedText
                    self.cardRedactorView?.updateDownSideCardView(cardModel: card)
                case .failure(let error):
                self.cardRedactorView?.showWarningAlert(title: "TranslateError".localized, message: error.localizedDescription)
            }
        }
    }
}
