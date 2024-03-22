import UIKit

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
        make.text = "--/---"
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
        make.setProgress(0.5, animated: true)
//        make.contentMode = .scaleToFill
        make.progressTintColor = .red
        make.trackTintColor = .blue
        make.tintColor = .black
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
//        make.contentHorizontalAlignment = .center
//        make.contentVerticalAlignment = .center
        make.translatesAutoresizingMaskIntoConstraints = false
//        make.configuration = .filled()
//        make.setTitle("", for: .normal)
        make.layer.cornerRadius = 25
        make.backgroundColor = .blue
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
    ///
    //////
    ///
    /////
    ///
    /////
    ///
    ///
    ///
    ///
    // MARK: -  Constrains
    func setConstrains() {
        NSLayoutConstraint.activate([
            exitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 14),
            exitButton.centerYAnchor.constraint(equalTo: learntWordsProgressView.centerYAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 40),
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            
            learntWordsProgressView.heightAnchor.constraint(equalToConstant: 5),
            learntWordsProgressView.topAnchor.constraint(equalTo: learntWordsLabel.bottomAnchor, constant: 5),
            learntWordsProgressView.leadingAnchor.constraint(equalTo: exitButton.trailingAnchor, constant: 8),
            learntWordsProgressView.trailingAnchor.constraint(equalTo: favouritesButton.leadingAnchor, constant: -8),
            
            learntWordsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            learntWordsLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            learntWordsLabel.heightAnchor.constraint(equalToConstant: 18),
            
            favouritesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -14),
            favouritesButton.centerYAnchor.constraint(equalTo: learntWordsProgressView.centerYAnchor),
            favouritesButton.widthAnchor.constraint(equalToConstant: 40),
            favouritesButton.heightAnchor.constraint(equalToConstant: 40),
            
            deckNameLabel.topAnchor.constraint(equalTo: learntWordsProgressView.bottomAnchor, constant: 8),
            deckNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            deckNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            //TEMP 134
//            deckNameLabel.heightAnchor.constraint(equalToConstant: 134),
            
            cardView.topAnchor.constraint(equalTo: deckNameLabel.bottomAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            cardView.trailingAnchor.constraint(equalTo: deckNameLabel.trailingAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            cardView.heightAnchor.constraint(equalTo: cardView.widthAnchor),
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            skipButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            skipButton.centerYAnchor.constraint(equalTo: invertButton.centerYAnchor),
            skipButton.widthAnchor.constraint(equalToConstant: 60),
            skipButton.heightAnchor.constraint(equalToConstant: 60),
            
            invertButton.leadingAnchor.constraint(equalTo: skipButton.trailingAnchor, constant: 40),
            invertButton.centerYAnchor.constraint(equalTo: acceptButton.centerYAnchor),
            invertButton.widthAnchor.constraint(equalToConstant: 138),
            invertButton.heightAnchor.constraint(equalToConstant: 60),

            acceptButton.leadingAnchor.constraint(equalTo: invertButton.trailingAnchor, constant: 40),
            acceptButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            acceptButton.widthAnchor.constraint(equalToConstant: 60),
            acceptButton.heightAnchor.constraint(equalToConstant: 60),


            
            

      



        ])
    }
}
