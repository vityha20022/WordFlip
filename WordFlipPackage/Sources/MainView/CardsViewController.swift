import UIKit
import SystemDesign
import NavigationModule
import Models

public final class CardsViewController: UIViewController {
    // MARK: - UI Elements
    private lazy var exitButton: UIButton = {
        let make = UIButton(primaryAction: exitButtonAction)
        make.contentMode = .scaleToFill
        make.contentHorizontalAlignment = .center
        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
        make.setImage(UIImage(systemName: "xmark"), for: .normal)
        make.configuration = .plain()
        make.isHidden = true
        make.setTitle("", for: .normal)
        make.isHidden = true
        return make
    }()

    private lazy var learntWordsLabel: UILabel = {
        let make = UILabel()
        make.contentMode = .left
        let learnedWords = String(deck?.learnedWordCounter ?? 0)
        let allWords = String(deck?.wordCounter ?? 0)
        make.text = "\(learnedWords)/\(allWords)"
        make.textAlignment = .natural
        make.lineBreakMode = .byTruncatingTail
        make.baselineAdjustment = .alignBaselines
        make.adjustsFontSizeToFitWidth = false
        make.translatesAutoresizingMaskIntoConstraints = false
        make.font = .systemFont(ofSize: 15)
        return make
    }()

    private lazy var learntWordsProgressView: UIProgressView = {
        let make = UIProgressView()
        make.progressViewStyle = .default
        let learnedWords = deck?.learnedWordCounter ?? 4
        let allWords = deck?.wordCounter ?? 20
        make.setProgress(Float(learnedWords) / Float(allWords), animated: true)
        make.trackTintColor = BaseColorScheme.baseTint.resolve()
        make.progressTintColor = BaseColorScheme.accent.resolve()
        make.translatesAutoresizingMaskIntoConstraints = false
        return make
    }()

    private lazy var favouritesButton: UIButton = {
        let make = UIButton(primaryAction: favouritesButtonAction)
        make.contentMode = .scaleToFill
        make.contentHorizontalAlignment = .center
        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
        make.setImage(UIImage(systemName: "star"), for: .normal)
        make.configuration = .plain()
        make.isHidden = true
        make.setTitle("", for: .normal)
        return make
    }()

    private lazy var deckNameLabel: UILabel = {
        let make = UILabel()
        make.contentMode = .left
        make.text = deck?.name ?? "Your deck name"
        make.textAlignment = .center
        make.lineBreakMode = .byTruncatingTail
        make.baselineAdjustment = .alignBaselines
        make.adjustsFontSizeToFitWidth = false
        make.translatesAutoresizingMaskIntoConstraints = false
        make.font = .systemFont(ofSize: 41)
        return make
    }()

    private lazy var invertButton: UIButton = {
        let make = UIButton(configuration: .tinted(), primaryAction: invertButtonAction)
        make.contentMode = .scaleToFill
        make.contentHorizontalAlignment = .center
        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
        make.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        make.setTitle("", for: .normal)
        return make
    }()

    private lazy var skipButton: UIButton = {
        let make = UIButton(configuration: .tinted(), primaryAction: skipButtonAction)
        make.contentMode = .scaleToFill
        make.contentHorizontalAlignment = .center
        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
        make.setImage(UIImage(systemName: "xmark"), for: .normal)
        make.setTitle("", for: .normal)
        return make
    }()

    private lazy var acceptButton: UIButton = {
        let make = UIButton(configuration: .tinted(), primaryAction: acceptButtonAction)
        make.contentMode = .scaleToFill
        make.contentHorizontalAlignment = .center
        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
        make.setImage(UIImage(systemName: "checkmark"), for: .normal)
        make.configuration = .tinted()
        make.layer.cornerRadius = 10
        make.setTitle("", for: .normal)
        return make
    }()

    public var stackCardsView: StackCardsView = {
        let make = StackCardsView()
        make.translatesAutoresizingMaskIntoConstraints = false
        return make
    }()

    // MARK: - Properties
    private var viewIsRotate: Bool = true

    private var presenter: CardsPresenterProtocol

    private var deck: DeckModel? {
        return presenter.getDeck()
    }
    
    private var currentCardIndex = 0

    var delegate: SwipeCardsDelegate?

    public init(presenter: CardsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: .none, bundle: .none)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Base View Properties
    public override func loadView() {
        setCountCardsFor(stackCardsView)
        view = UIView()
        setViewHierachy()
        setConstrains()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        stackCardsView.dataSource = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        stackCardsView.reloadData()
    }

    func setCountCardsFor(_ stackContainer: StackCardsView) {
        if (UIScreen.main.bounds.height) <= 667.0 {
            stackContainer.cardsToBeVisible = 2
        } else {
            stackContainer.cardsToBeVisible = 3
        }
    }

    // MARK: - Actions buttons
    private lazy var invertButtonAction = UIAction(handler: { [weak self] _ in
        guard
            let self = self,
            let card = self.stackCardsView.visibleCards.last
        else {return}
        card.handleTapGesture()

    })

    private lazy var skipButtonAction = UIAction(handler: { [weak self] _ in
        guard let self = self else { return }
        guard let card = self.stackCardsView.visibleCards.last else { return }
        card.swipeLeftAction()
    })

    private lazy var acceptButtonAction = UIAction(handler: { [weak self] _ in
        guard let self = self else { return }
        guard let card = self.stackCardsView.visibleCards.last else {return}
        card.swipeRightAction()
    })

    private lazy var exitButtonAction = UIAction(handler: { [weak self] _ in

    })

    private lazy var favouritesButtonAction = UIAction(handler: { [weak self] sender in
        guard let sender = sender.sender as? UIButton else { return }

    })

    // MARK: - View Hierachy
    private func setViewHierachy() {
        view.addSubview(invertButton)
        view.addSubview(learntWordsProgressView)
        view.addSubview(favouritesButton)
        view.addSubview(deckNameLabel)
        view.addSubview(learntWordsLabel)
        view.addSubview(skipButton)
        view.addSubview(acceptButton)
        view.addSubview(exitButton)
        view.addSubview(stackCardsView)
    }

    // MARK: - Constrains
    private func setConstrains() {
        NSLayoutConstraint.activate([
            // - exitButton
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            exitButton.centerYAnchor.constraint(equalTo: learntWordsProgressView.centerYAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 40),
            exitButton.heightAnchor.constraint(equalToConstant: 40),

            // - learntWordsProgressView
            learntWordsProgressView.heightAnchor.constraint(equalToConstant: 5),
            learntWordsProgressView.topAnchor.constraint(equalTo: learntWordsLabel.bottomAnchor, constant: 5),
            learntWordsProgressView.leadingAnchor.constraint(equalTo: exitButton.trailingAnchor, constant: 8),
            learntWordsProgressView.trailingAnchor.constraint(equalTo: favouritesButton.leadingAnchor, constant: -8),

            // - learntWordsLabel
            learntWordsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            learntWordsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            learntWordsLabel.heightAnchor.constraint(equalToConstant: 18),

            // - favouritesButton
            favouritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            favouritesButton.centerYAnchor.constraint(equalTo: learntWordsProgressView.centerYAnchor),
            favouritesButton.widthAnchor.constraint(equalToConstant: 40),
            favouritesButton.heightAnchor.constraint(equalToConstant: 40),

            // - deckNameLabel
            deckNameLabel.topAnchor.constraint(equalTo: learntWordsProgressView.bottomAnchor, constant: 8),
            deckNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deckNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // - skipButton
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skipButton.widthAnchor.constraint(equalToConstant: 60),
            skipButton.heightAnchor.constraint(equalToConstant: 60),

            // - invertButton
            invertButton.leadingAnchor.constraint(equalTo: skipButton.trailingAnchor, constant: 40),
            invertButton.centerYAnchor.constraint(equalTo: skipButton.centerYAnchor),
            invertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            invertButton.heightAnchor.constraint(equalToConstant: 60),

            // - acceptButton
            acceptButton.leadingAnchor.constraint(equalTo: invertButton.trailingAnchor, constant: 40),
            acceptButton.centerYAnchor.constraint(equalTo: invertButton.centerYAnchor),
            acceptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            acceptButton.widthAnchor.constraint(equalToConstant: 60),
            acceptButton.heightAnchor.constraint(equalToConstant: 60),

            // - stackContainer
            stackCardsView.heightAnchor.constraint(equalToConstant: 350),
            stackCardsView.widthAnchor.constraint(equalToConstant: 350),
            stackCardsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackCardsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackCardsView.topAnchor.constraint(equalTo: deckNameLabel.bottomAnchor, constant: 0),
        ])
    }
}

// MARK: - Extension
extension CardsViewController: SwipeCardsDataSource {
    public func numberOfCardsToShow() -> Int {
        return deck?.wordCounter ?? 1
    }

    public func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = deck?.cards[index]
        return card
    }
    
    public func currentCard() -> CardModel? {
        return presenter.getDeck()?.cards[currentCardIndex]
    }
}
