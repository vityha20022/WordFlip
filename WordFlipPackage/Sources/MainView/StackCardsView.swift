import UIKit
import Models

public class StackCardsView: UIView {
    // MARK: - Properties
    var numberOfCardsToShow: Int = 0
    var cardsToBeVisible: Int = 3
    var cardViews: [SwipeCardView] = []
    var remainingcards: Int = 0

    let horizontalInset: CGFloat = 10.0
    let verticalInset: CGFloat = 10.0

    var visibleCards: [SwipeCardView] {
        return subviews as? [SwipeCardView] ?? []
    }
    
    var dataSource: SwipeCardsDataSource? {
        didSet {
            reloadData()
        }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reloadData() {
        guard let dataSource = dataSource else { return }
        setNeedsLayout()
        layoutIfNeeded()
        numberOfCardsToShow = dataSource.numberOfCardsToShow()
        remainingcards = numberOfCardsToShow

        for i in visibleCards {
            i.removeFromSuperview()
        }
        
        for i in 0..<min(numberOfCardsToShow, cardsToBeVisible) {
            print(i)
            let cardView = SwipeCardView()
            print(dataSource.currentCard()?.deckId)
            let cardModel = dataSource.card(at: i).dataSource
            cardView.dataSource = cardModel

            let successesForRememberCount = max(UserDefaults.standard.integer(forKey: "SelectedNumberOfWords"), 1)

            if cardModel?.guessCounter ?? 0 >= successesForRememberCount {
                continue
            }
            
            addCardView(cardView: cardView, atIndex: i)
            visibleCards.last?.isCanFlip = true
        }
        
        if visibleCards.isEmpty {
            let cardView = SwipeCardView()
            let cardModel = CardModel(deckId: "", frontText: "Choose deck", downText: "Choose deck")
            cardView.dataSource = cardModel
            addCardView(cardView: cardView, atIndex: 0)
            visibleCards.last?.isCanFlip = true
        }
        print("reloaded")
    }

    private func addCardView(cardView: SwipeCardView, atIndex index: Int) {
        //print("Add \(cardView.dataSource?.id) view: \(cardView.dataSource?.guessCounter)")
        cardView.delegate = self
        addCardFrame(index: index, cardView: cardView)
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
        remainingcards -= 1
    }

    func addCardFrame(index: Int, cardView: SwipeCardView) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        let verticalInset = CGFloat(index) * self.verticalInset

        cardViewFrame.size.width -= 2 * horizontalInset
        cardViewFrame.origin.x += horizontalInset
        cardViewFrame.origin.y += verticalInset

        cardView.frame = cardViewFrame
    }
}

// MARK: - Extension
extension StackCardsView: SwipeCardsDelegate {
    public func swipeDidEnd(on view: SwipeCardView, swipeDirection: SwipeDirection) {
        guard let datasource = dataSource else { return }

        view.removeFromSuperview()
        
        var cardModel = view.dataSource
        
        switch swipeDirection {
            case .right:
                cardModel?.guessCounter += 1
            case .left:
                cardModel?.guessCounter = 0
        }
        
        if let cardModel = cardModel {
            self.dataSource?.getPresenter().saveCard(cardModel: cardModel)
            print("deckID: \(cardModel.deckId)")
        }

        if self.remainingcards > 0 {
            if visibleCards.count <= 2 {
                let newIndex = datasource.numberOfCardsToShow() - self.remainingcards
                let cardModel = datasource.card(at: newIndex).dataSource

                let successesForRememberCount = max(UserDefaults.standard.integer(forKey: "SelectedNumberOfWords"), 1)

                if cardModel?.guessCounter ?? 0 < successesForRememberCount {
                    self.addCardView(cardView: datasource.card(at: newIndex), atIndex: 2)
                    for (cardIndex, cardView) in self.visibleCards.reversed().enumerated() {
                        UIView.animate(withDuration: 0.2, animations: {
                            cardView.center = self.center
                            self.addCardFrame(index: cardIndex, cardView: cardView)
                            self.layoutIfNeeded()
                        })
                    }
                    visibleCards.last?.isCanFlip = true
                }
            }
        } else {
            for (cardIndex, cardView) in self.visibleCards.reversed().enumerated() {
                UIView.animate(withDuration: 0.2, animations: {
                    cardView.center = self.center
                    self.addCardFrame(index: cardIndex, cardView: cardView)
                    self.layoutIfNeeded()
                })
                visibleCards.last?.isCanFlip = true
            }
        }
        
        self.dataSource?.updateLabels()
    }
}
