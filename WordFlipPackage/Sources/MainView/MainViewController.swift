import UIKit
import SystemDesign

public class MainViewController: UIViewController {
    // MARK: -  UI Elements
    private lazy var exitButton: UIButton = {
        let make = UIButton()
        make.contentMode = .scaleToFill
        make.contentHorizontalAlignment = .center
        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
        make.setTitle("Button", for: .normal)
        make.setImage(UIImage(systemName: "xmark"), for: .normal)
        make.configuration = .plain()
        make.setTitle("", for: .normal)
        return make
    }()

    
    private lazy var learntWordsLabel: UILabel = {
        let make = UILabel()
        make.contentMode = .left
        make.text = "25/500"
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
        make.setProgress(0.05, animated: true)
        make.trackTintColor = BaseColorScheme.baseTint.resolve()
        make.progressTintColor = BaseColorScheme.accent.resolve()
        make.translatesAutoresizingMaskIntoConstraints = false
        return make
    }()
    
    private lazy var favouritesButton: UIButton = {
        let make = UIButton()
        make.contentMode = .scaleToFill
        make.contentHorizontalAlignment = .center
        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
        make.setImage(UIImage(systemName: "star"), for: .normal)
        make.configuration = .plain()
        make.setTitle("", for: .normal)
        return make
    }()
    
    private lazy var deckNameLabel: UILabel = {
        let make = UILabel()
        make.contentMode = .left
        make.text = "Animals"
        make.textAlignment = .center
        make.lineBreakMode = .byTruncatingTail
        make.baselineAdjustment = .alignBaselines
        make.adjustsFontSizeToFitWidth = false
        make.translatesAutoresizingMaskIntoConstraints = false
        make.font = .systemFont(ofSize: 41)
        return make
    }()
    
    private lazy var cardView: UIView = {
        let make = UIView()
        make.contentMode = .scaleToFill
        make.translatesAutoresizingMaskIntoConstraints = false
        make.layer.cornerRadius = 45
        make.backgroundColor = BaseColorScheme.baseTint.resolve()
        //make.backgroundColor = BaseColorScheme.accent.resolve()
        make.layer.shadowOffset = CGSize(width: 0, height: 0)
        make.layer.shadowOpacity = 0.5
        make.layer.shadowRadius = 5
        make.addSubview(cardViewText)
        return make
    }()
    

    
    private lazy var cardViewText: UILabel = {
        let make = UILabel()
        make.contentMode = .left
        make.text = "Animal"
        make.textColor = #colorLiteral(red: 0.2410846055, green: 0.5627357364, blue: 0.9369452596, alpha: 1)
        make.textAlignment = .center
        make.lineBreakMode = .byTruncatingTail
        make.baselineAdjustment = .alignBaselines
        make.adjustsFontSizeToFitWidth = false
        make.translatesAutoresizingMaskIntoConstraints = false
        make.font = .systemFont(ofSize: 41)
        return make
    }()
    
    private lazy var invertButton: UIButton = {
        let make = UIButton()
        make.contentMode = .scaleToFill
        make.contentHorizontalAlignment = .center
        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
        make.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        make.configuration = .tinted()
        make.setTitle("", for: .normal)
        return make
    }()

    private lazy var skipButton: UIButton = {
        let make = UIButton()
        make.contentMode = .scaleToFill
        make.contentHorizontalAlignment = .center
        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
        make.setImage(UIImage(systemName: "xmark"), for: .normal)
        make.configuration = .tinted()
        make.setTitle("", for: .normal)
        return make
    }()
    
    private lazy var acceptButton: UIButton = {
        let make = UIButton()
        make.contentMode = .scaleToFill
        make.contentHorizontalAlignment = .center
        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
        make.setImage(UIImage(systemName: "checkmark"), for: .normal)
        make.configuration = .tinted()
        make.setTitle("", for: .normal)
        return make
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: -  Base View Properties
        view.backgroundColor = .systemBackground
        
        setViewHierachy()
        setConstrains()
    }
    
    
    // MARK: -  View Hierachy
    func setViewHierachy() {
        view.addSubview(invertButton)
        view.addSubview(learntWordsProgressView)
        view.addSubview(favouritesButton)
        view.addSubview(deckNameLabel)
        view.addSubview(learntWordsLabel)
        view.addSubview(skipButton)
        view.addSubview(acceptButton)
        view.addSubview(exitButton)
        view.addSubview(cardView)
    }
    // MARK: -  Constrains
    func setConstrains() {
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
            
            // - cardView
            cardView.topAnchor.constraint(equalTo: deckNameLabel.bottomAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cardView.trailingAnchor.constraint(equalTo: deckNameLabel.trailingAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.heightAnchor.constraint(equalTo: cardView.widthAnchor),
            
            // - cardViewText
            cardViewText.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30),
            cardViewText.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30),
            cardViewText.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            cardViewText.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),

            // - skipButton
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
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
        ])
    }
}
