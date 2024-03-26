import UIKit
import SystemDesign
import Models

public protocol SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> SwipeCardView
}

public protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: SwipeCardView)
}

public class SwipeCardView: UIView{
    //MARK: - Properties
    private var cardView: UIView = {
        let make = UIView()
        make.contentMode = .scaleToFill
        make.layer.cornerRadius = 45
        make.backgroundColor = BaseColorScheme.baseTint.resolve()
        make.translatesAutoresizingMaskIntoConstraints = false
        return make
    }()
    
    private var cardViewText: UILabel = {
        let make = UILabel()
        make.contentMode = .left
        make.text = ""
        make.textColor = BaseColorScheme.cardText.resolve()
        make.textAlignment = .center
        make.lineBreakMode = .byTruncatingTail
        make.baselineAdjustment = .alignBaselines
        make.adjustsFontSizeToFitWidth = false
        make.font = .systemFont(ofSize: 41)
        make.translatesAutoresizingMaskIntoConstraints = false
        return make
    }()
    
    var shadowView: UIView = {
        let make = UIView()
        make.backgroundColor = .clear
        make.layer.shadowColor = UIColor.black.cgColor
        make.layer.shadowOffset = CGSize(width: 0, height: 0)
        make.layer.shadowOpacity = 0.8
        make.layer.shadowRadius = 4.0
        make.translatesAutoresizingMaskIntoConstraints = false
        return make
    }()
    
    var delegate: SwipeCardsDelegate?

    var divisor: CGFloat = 0
    let baseView = UIView()
    
    var dataSource: CardModel? {
        didSet {
            cardViewText.text = dataSource?.frontText
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViewHierachy()
        setConstrains()
        configureTapGesture()
        addPanGestureOnCards()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func setViewHierachy() {
        addSubview(shadowView)
        shadowView.addSubview(cardView)
        cardView.addSubview(cardViewText)
    }
    func setConstrains() {
        NSLayoutConstraint.activate([
            cardView.leftAnchor.constraint(equalTo: shadowView.leftAnchor),
            cardView.rightAnchor.constraint(equalTo: shadowView.rightAnchor),
            cardView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            cardView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            
            cardViewText.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30),
            cardViewText.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30),
            cardViewText.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            cardViewText.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),
            
            shadowView.leftAnchor.constraint(equalTo: leftAnchor),
            shadowView.rightAnchor.constraint(equalTo: rightAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

    func configureTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }


    func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    //MARK: - Handlers
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        let card = sender.view as! SwipeCardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
//
//        let distanceFromCenter = ((UIScreen.main.bounds.width / 2) - card.center.x)
        
        divisor = ((UIScreen.main.bounds.width / 2) / 0.61)
       
        switch sender.state {
        case .ended:
            if (card.center.x) > 300 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }else if card.center.x < 100 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            let rotation = tan(point.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
            
        default:
            break
        }
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer){
        
    }
}
