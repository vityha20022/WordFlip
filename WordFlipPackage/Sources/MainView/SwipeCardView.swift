import UIKit
import SystemDesign
import Models

public protocol SwipeCardsDataSource: AnyObject {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> SwipeCardView
}

public protocol SwipeCardsDelegate: AnyObject {
    func swipeDidEnd(on view: SwipeCardView)
}

public class SwipeCardView: UIView {
    // MARK: - Properties
    private var cardView: UIView = {
        let make = UIView()
        make.contentMode = .scaleToFill
        make.layer.cornerRadius = 45
        make.backgroundColor = BaseColorScheme.frontSideCardColor.resolve()
        make.translatesAutoresizingMaskIntoConstraints = false
        return make
    }()

    var viewIsRotate: Bool = true
    var isCanFlip: Bool = false
    var cardViewFrontText: String = ""
    var cardViewDownText: String = ""

    private var cardViewText: UILabel = {
        let make = UILabel()
        make.contentMode = .left
        make.text = ""
        make.textColor = BaseColorScheme.downSideCardColor.resolve()
        make.textAlignment = .center
        make.lineBreakMode = .byTruncatingTail
        make.baselineAdjustment = .alignBaselines
        make.adjustsFontSizeToFitWidth = false
        make.font = .systemFont(ofSize: 41)
        make.numberOfLines = 4
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
            cardViewFrontText = dataSource?.frontText ?? "Pick your deck\n🤗"
            cardViewDownText = dataSource?.downText ?? "Выбери колоду\n👇🏻"
            cardViewText.text = cardViewFrontText
        }
    }

    // MARK: - Init
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

    // MARK: - Configuration
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
            shadowView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }

    func configureTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }

    func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }

    // MARK: - Handlers
    @objc
    func handlePanGesture(sender: UIPanGestureRecognizer) {
        guard let card = sender.view as? SwipeCardView else { return }
        let generator = UINotificationFeedbackGenerator()
        let lightFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)

        divisor = ((UIScreen.main.bounds.width / 2) / 0.61)

        switch sender.state {
        case .ended:
            if (card.center.x) > 300 {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                } completion: { _ in
                    generator.notificationOccurred(.success)
                    self.delegate?.swipeDidEnd(on: card)
                }
                return
            } else if card.center.x < 100 {
                UIView.animate(withDuration: 0.3) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                } completion: { _ in
                    lightFeedbackGenerator.impactOccurred()
                    self.delegate?.swipeDidEnd(on: card)

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
            self.cardViewText.transform = .identity

        default:
            break
        }
    }

    @objc
    public func handleTapGesture() {
        guard self.isCanFlip else { return }
        let card = self
        let layer = card.layer
        let mediumFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        let heavyFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        var rotationAndPerspectiveTransform = CATransform3DIdentity

        if viewIsRotate {
            mediumFeedbackGenerator.impactOccurred()
            layer.zPosition = 1_000
            UIView.animate(withDuration: 0.2) {
                rotationAndPerspectiveTransform.m34 = 1.0 / -300
                rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, .pi, 0.0, 1.0, 0.0)
                layer.transform = rotationAndPerspectiveTransform
                rotationAndPerspectiveTransform.m34 = 1.0 / 300
                self.cardView.backgroundColor = BaseColorScheme.downSideCardColor.resolve()
                self.cardViewText.textColor = BaseColorScheme.frontSideCardColor.resolve()
                self.cardViewText.layer.transform = rotationAndPerspectiveTransform
                self.cardViewText.text = self.cardViewDownText
            }
            self.setNeedsLayout()
            self.layoutIfNeeded()
            viewIsRotate.toggle()

        } else {
            heavyFeedbackGenerator.impactOccurred()
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                self.cardView.backgroundColor = BaseColorScheme.frontSideCardColor.resolve()
                self.cardViewText.textColor = BaseColorScheme.downSideCardColor.resolve()
                self.cardViewText.transform = .identity
                self.cardViewText.text = self.cardViewFrontText
            }

            self.setNeedsLayout()
            self.layoutIfNeeded()
            viewIsRotate.toggle()
        }
    }

    public func swipeRightAction() {
        let generator = UINotificationFeedbackGenerator()
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.center = CGPoint(x: centerOfParentContainer.x, y: centerOfParentContainer.y)
        generator.notificationOccurred(.success)

        UIView.animate(withDuration: 0.3) {
            let rotation = tan((self.frame.width * 2.0))
            self.transform = CGAffineTransform(rotationAngle: rotation)
            self.cardViewText.transform = .identity
            self.center = CGPoint(x: centerOfParentContainer.x + 500, y: centerOfParentContainer.y + 75)
            self.alpha = 0
            self.layoutIfNeeded()
        } completion: { _ in
            self.delegate?.swipeDidEnd(on: self)
        }
        return
    }

    public func swipeLeftAction() {
        let lightFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.center = CGPoint(x: centerOfParentContainer.x, y: centerOfParentContainer.y)
        lightFeedbackGenerator.impactOccurred()

        UIView.animate(withDuration: 0.3) {
            let rotation = tan((-self.frame.width * 2.0))
            self.transform = CGAffineTransform(rotationAngle: rotation)
            self.cardViewText.transform = .identity

            self.center = CGPoint(x: centerOfParentContainer.x - 500, y: centerOfParentContainer.y + 75)
            self.alpha = 0
            self.layoutIfNeeded()
        } completion: { _ in
            lightFeedbackGenerator.impactOccurred()
            self.delegate?.swipeDidEnd(on: self)
        }
        return
    }
}
