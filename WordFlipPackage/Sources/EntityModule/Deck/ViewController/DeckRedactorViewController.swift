import UIKit
import SystemDesign
import Models

protocol DeckRedactorViewProtocol: AnyObject {
    func showPreviousController()
    func showCardRedactorController(with configuration: CardRedactorConfiguration, dataManager: EntityDataManager, cardId: String, deckId: String)
    func removeCell(at index: Int)
    func showWarningAlert(message: String)
}

public struct DeckRedactorConfiguration {
    let title: String

    public init(title: String) {
        self.title = title
    }
}

final public class DeckRedactorViewController: UIViewController {

    private let presenter: DeckRedactorPresenterProtocol

    private let configuration: DeckRedactorConfiguration

    private let deckView = DeckView()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .tinted()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()

    private let cardsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        return tableView
    }()

    init(presenter: DeckRedactorPresenterProtocol, configuration: DeckRedactorConfiguration) {
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
        
        cardsTableView.reloadData()
        deckView.configure(with: presenter.getDeckData(), isEditable: true)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }

    private func setup() {
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        
        let tapPlusAction = UIAction {[weak self] _ in
            self?.presenter.didTapAdd()
        }
        plusButton.addAction(tapPlusAction, for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        hideKeyboardWhenTappedAround()

        deckView.configure(with: presenter.getDeckData(), isEditable: true)

        view.backgroundColor = BaseColorScheme.backgroundColor.resolve()

        headerLabel.text = configuration.title

        let safeArea = view.safeAreaLayoutGuide

        view.addSubview(headerLabel)
        view.addSubview(plusButton)
        view.addSubview(cardsTableView)
        view.addSubview(deckView)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: ComponentMetrics.headerTitleTopMarginWithNavBar),
            headerLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),

            plusButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),

            deckView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            deckView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            deckView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            deckView.bottomAnchor.constraint(equalTo: cardsTableView.topAnchor, constant: 0),

            cardsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            cardsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            cardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc
    private func doneButtonTapped() {
        presenter.didTapDone(deckName: deckView.getDeckName())
    }
    
    @objc
    private func backButtonTapped() {
        presenter.didTapBack()
        navigationController?.popViewController(animated: true)
    }
}

extension DeckRedactorViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCardsData().count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell else {
            fatalError("No cell with such identifier.")
        }

        let model = presenter.getCardsData()[indexPath.row]
        cell.configure(with: model)

        return cell
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    // MARK: - UITableViewDelegate

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions = [UIContextualAction]()

        let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            completion(true)
            self?.presenter.didTapDelete(index: indexPath.row)
        }

        let editAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            completion(true)
            self?.presenter.didTapEdit(index: indexPath.row)
        }

        let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0, weight: .bold, scale: .large)

        deleteAction.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed, 50)
        deleteAction.backgroundColor = BaseColorScheme.backgroundColor.resolve().withAlphaComponent(0)

        actions.append(deleteAction)

        editAction.image = UIImage(systemName: "pencil", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemOrange, 50)
        editAction.backgroundColor = BaseColorScheme.backgroundColor.resolve().withAlphaComponent(0)

        actions.append(editAction)

        let config = UISwipeActionsConfiguration(actions: actions)
        config.performsFirstActionWithFullSwipe = false

        return config
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIImage {
    func addBackgroundCircle(_ color: UIColor?, _ diameter: Double) -> UIImage? {
        let circleDiameter = diameter
        let circleRadius = circleDiameter * 0.5
        let circleSize = CGSize(width: circleDiameter, height: circleDiameter)
        let circleFrame = CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height)
        let imageFrame = CGRect(x: circleRadius - (size.width * 0.5), y: circleRadius - (size.height * 0.5), width: size.width, height: size.height)

        let view = UIView(frame: circleFrame)
        view.backgroundColor = color ?? .systemRed
        view.layer.cornerRadius = circleDiameter * 0.5

        UIGraphicsBeginImageContextWithOptions(circleSize, false, UIScreen.main.scale)

        let renderer = UIGraphicsImageRenderer(size: circleSize)
        let circleImage = renderer.image { _ in
            view.drawHierarchy(in: circleFrame, afterScreenUpdates: true)
        }

        circleImage.draw(in: circleFrame, blendMode: .normal, alpha: 1.0)
        draw(in: imageFrame, blendMode: .normal, alpha: 1.0)

        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }
}

extension DeckRedactorViewController: DeckRedactorViewProtocol {
    func showPreviousController() {
        navigationController?.popViewController(animated: true)
    }
    
    func showCardRedactorController(with configuration: CardRedactorConfiguration, dataManager: EntityDataManager, cardId: String, deckId: String) {
        let cardRedactorVC = CardRedactorBuilder(dataManager: dataManager, configuration: configuration, cardId: cardId, deckId: deckId).build()
        navigationController?.pushViewController(cardRedactorVC, animated: true)
    }
    
    func removeCell(at index: Int) {
        cardsTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        deckView.configure(with: presenter.getDeckData(), isEditable: true)
    }
    
    func showWarningAlert(message: String) {
        let alert = UIAlertController(title: "Empty deck name", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
