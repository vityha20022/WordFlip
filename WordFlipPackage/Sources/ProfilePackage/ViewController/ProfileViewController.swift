import UIKit
import SystemDesign

public final class ProfileViewController: UIViewController {

    private let profileTableView: UITableView = UITableView()
    private let exitButton = DefaultButton(text: "Sign out".localized, color: BaseColorScheme.red)
    private let deleteButton = UIButton()
    private let titleLabel = UILabel()
    private let presenter: ProfilePresenterProtocol

    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(exitButton)
        view.addSubview(deleteButton)
        view.addSubview(profileTableView)
        view.addSubview(titleLabel)

        navigationItem.title = "Profile".localized

        configureView()
        configureExitButton()
        configureDeleteButton()
        configureTableView()
        configureTitleLable()
        
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func exitButtonTapped() {
        presenter.didTapSignOutButton()
    }

    private func configureView() {
        view.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        view.accessibilityIdentifier = "ProfileViewControllerIdentifier"
    }

    private func configureExitButton() {
        exitButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            exitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            exitButton.heightAnchor.constraint(equalToConstant: 65),
            exitButton.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -10),

        ])
    }

    private func configureDeleteButton() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.setTitle("DeleteAccount".localized, for: .normal)
        deleteButton.setTitleColor(BaseColorScheme.red.resolve(), for: .normal)
        deleteButton.titleLabel?.font = .boldSystemFont(ofSize: 20)

        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            deleteButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }

    private func configureTitleLable() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Profile".localized
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])

    }

    private func configureTableView() {
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.separatorStyle = .none

        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: exitButton.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getDataArray().count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CustomCellProtocoll

        if indexPath.row == 0 {

            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserTableViewCell {
                cell = reuseCell
            } else {
                cell = UserTableViewCell(style: .default, reuseIdentifier: "UserCell")
            }

        } else {

            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell") as? DefaultTableViewCell {
                cell = reuseCell
            } else {
                cell = DefaultTableViewCell(style: .default, reuseIdentifier: "DefaultCell")
            }

        }

        configureCell(cell: cell, for: indexPath)

        return cell
    }

    private func configureCell(cell: CustomCellProtocoll, for indexPath: IndexPath) {
        let model = presenter.getDataArray()[indexPath.row]
        cell.configure(image: model.image, text: model.labelText, isOn: model.isOn, selectedNumber: nil, closureForAction: model.closureForAction)
        cell.selectionStyle = .none
    }

}

extension ProfileViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapSettings(cellIndex: indexPath.row)
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func showSettingsScreen() {
        navigationController?.pushViewController(SettingsBuilder().build(), animated: true)
    }

    func showAppInfoAlert() {
        let alertController = UIAlertController(
            title: "About the program".localized,
            message: """
            WordFlip - эффективный и удобный способ улучшить свои навыки, независимо от вашего уровня владения языком.
            Обучение с помощью карточек позволит вам обогатить словарный запас независимо от вашего уровня владения языком.

            Разработчики:
                - Борисовский Виктор
                - Брюханов Захар
                - Кисляков Никита
                - Симоненко Павел
            Отдельная благодарность:
                - Сницарюк Роман
            """,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }
}
