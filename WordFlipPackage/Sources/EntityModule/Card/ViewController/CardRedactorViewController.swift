import UIKit
import SystemDesign
import Models

protocol CardRedactorViewProtocol: AnyObject {
    func showPreviousController()
    func showWarningAlert(title: String, message: String)
    func updateDownSideCardView(cardModel: CardModel)
}

public struct CardRedactorConfiguration {
    let title: String

    public init(title: String) {
        self.title = title
    }
}

final public class CardRedactorViewController: UIViewController {
    
    private let presenter: CardRedactorPresenterProtocol
    
    private let configuration: CardRedactorConfiguration
    
    private var languageDict = [String: String]()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let frontSideCardView = CardView(for: .front)
    private let downSideCardView = CardView(for: .down)

    private let translateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .tinted()
        button.setTitle("Translate".localized, for: .normal)
        return button
    }()

    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsMenuAsPrimaryAction = true
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(BaseColorScheme.accent.resolve(), for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 7

        var menuActions = [UIAction]()

        for language in Language.allCases {
            languageDict[language.languageName] = language.rawValue
            let action = UIAction(title: "\(language.languageName)", handler: { _ in
                button.setTitle("\(language.languageName)", for: .normal)
            })
            menuActions.append(action)
        }

        let menu = UIMenu(title: "Sourcelanguage".localized, children: menuActions)
        button.menu = menu
        button.setTitle(Language.english.languageName, for: .normal)

        return button
    }()

    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsMenuAsPrimaryAction = true
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(BaseColorScheme.accent.resolve(), for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 7

        var menuActions = [UIAction]()

        for language in Language.allCases {
            languageDict[language.languageName] = language.rawValue
            let action = UIAction(title: "\(language.languageName)", handler: { _ in
                button.setTitle("\(language.languageName)", for: .normal)
            })
            menuActions.append(action)
        }

        let menu = UIMenu(title: "Targetlanguage".localized, children: menuActions)
        button.menu = menu
        button.setTitle(Language.russian.languageName, for: .normal)

        return button
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.forward"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    init(presenter: CardRedactorPresenterProtocol, configuration: CardRedactorConfiguration) {
        self.presenter = presenter
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    private func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done".localized, style: .done, target: self, action: #selector(doneButtonTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        translateButton.addTarget(self, action: #selector(translateButtonTapped), for: .touchUpInside)
        
        hideKeyboardWhenTappedAround()

        frontSideCardView.configure(with: presenter.getCardData())
        downSideCardView.configure(with: presenter.getCardData())

        view.backgroundColor = BaseColorScheme.backgroundColor.resolve()

        headerLabel.text = configuration.title

        let safeArea = view.safeAreaLayoutGuide

        view.addSubview(headerLabel)
        view.addSubview(frontSideCardView)
        view.addSubview(translateButton)
        view.addSubview(downSideCardView)
        view.addSubview(sourceLanguageButton)
        view.addSubview(arrowImageView)
        view.addSubview(targetLanguageButton)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: ComponentMetrics.headerTitleTopMargin),
            headerLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),

            translateButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            translateButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),

            sourceLanguageButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            sourceLanguageButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            sourceLanguageButton.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -5),

            arrowImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 30),
            arrowImageView.heightAnchor.constraint(equalToConstant: 30),
            arrowImageView.centerYAnchor.constraint(equalTo: targetLanguageButton.centerYAnchor),

            targetLanguageButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            targetLanguageButton.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: 5),
            targetLanguageButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),

            frontSideCardView.topAnchor.constraint(equalTo: sourceLanguageButton.bottomAnchor, constant: 20),
            frontSideCardView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            frontSideCardView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            frontSideCardView.bottomAnchor.constraint(equalTo: downSideCardView.topAnchor, constant: -10),

            downSideCardView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            downSideCardView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            downSideCardView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),

            frontSideCardView.heightAnchor.constraint(equalTo: downSideCardView.heightAnchor),
        ])
    }

    @objc
    private func translateButtonTapped() {
        let sourceLanguage = Language(rawValue: languageDict[sourceLanguageButton.titleLabel?.text ?? ""] ?? "")
        let targetLanguage = Language(rawValue: languageDict[targetLanguageButton.titleLabel?.text ?? ""] ?? "")
        presenter.didTapTranslaste(sourceLanguage: sourceLanguage, targetLanguage: targetLanguage, text: frontSideCardView.getCardText())
    }
    
    @objc
    private func doneButtonTapped() {
        presenter.didTapDone(frontSideText: frontSideCardView.getCardText(), downSideText: downSideCardView.getCardText())
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension CardRedactorViewController: CardRedactorViewProtocol {
    func showPreviousController() {
        navigationController?.popViewController(animated: true)
    }
        
    func showWarningAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateDownSideCardView(cardModel: CardModel) {
        downSideCardView.configure(with: cardModel)
    }
}
