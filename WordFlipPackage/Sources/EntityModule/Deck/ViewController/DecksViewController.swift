import UIKit
import SystemDesign
import Models

protocol DecksViewProtocol: AnyObject {
    func removeCell(at index: Int)

    func showDeckRedactor(with configuration: DeckRedactorConfiguration, dataManager: EntityDataManager, deckId: String)
}

final public class DecksViewController: UIViewController {

    private let presenter: DecksPresenterProtocol

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DeckCell.self, forCellReuseIdentifier: DeckCell.identifier)
        return tableView
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Decks"
        return label
    }()

    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .tinted()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()

    init(presenter: DecksPresenterProtocol) {
        self.presenter = presenter
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
        
        tableView.reloadData()
    }

    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self

        let tapPlusAction = UIAction {[weak self] _ in
            self?.presenter.didTapAdd()
        }
        plusButton.addAction(tapPlusAction, for: .touchUpInside)

        view.backgroundColor = BaseColorScheme.backgroundColor.resolve()

        let safeArea = view.safeAreaLayoutGuide

        view.addSubview(headerLabel)
        view.addSubview(plusButton)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                             constant: ComponentMetrics.headerTitleTopMargin),
            headerLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),

            plusButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),

            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}

extension DecksViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getData().count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeckCell.identifier, for: indexPath)
                as? DeckCell else {
            fatalError("No cell with such identifier.")
        }

        let model = presenter.getData()[indexPath.row]
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

extension DecksViewController: DecksViewProtocol {
    func removeCell(at index: Int) {
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
    }

    func showDeckRedactor(with configuration: DeckRedactorConfiguration, dataManager: EntityDataManager, deckId: String) {
        let deckRedactorVC = DeckRedactorBuilder(dataManager: dataManager, configuration: configuration, deckId: deckId).build()
        navigationController?.pushViewController(deckRedactorVC, animated: true)
    }
}
