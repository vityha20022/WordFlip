import UIKit
import SystemDesign

public final class SettingsViewController: UIViewController {

    private let settingsTableView: UITableView = UITableView()
    private let titleLabel = UILabel()

    private let presenter: SettingsPresenterProtocol

    init(presenter: SettingsPresenterProtocol) {
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

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    private func setupLayout() {
        view.addSubview(settingsTableView)
        view.addSubview(titleLabel)

        configureView()
        configureTitleLable()
        configureTableView()
    }

    private func configureView() {
        view.backgroundColor = BaseColorScheme.backgroundColor.resolve()
    }

    private func configureTitleLable() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Settings".localized
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }

    private func configureTableView() {
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self

        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension SettingsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getDataArray().count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CustomCellProtocoll
        let model = presenter.getDataArray()[indexPath.row]

        if indexPath.row == 0 {

            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "SettingsSwitchCell") as? SettingsSwitchTableViewCell {
                cell = reuseCell
            } else {
                cell = SettingsSwitchTableViewCell(style: .default, reuseIdentifier: "SettingsSwitchCell")
            }

        } else if indexPath.row == 1 {

            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "SettingsMenuCell") as? SettingsMenuTableViewCell {
                cell = reuseCell
            } else {
                cell = SettingsMenuTableViewCell(style: .default, reuseIdentifier: "SettingsMenuCell", data: model.data)
            }

        } else {

            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "SettingsDefaultCell") as? SettingsDefaultTableViewCell {
                cell = reuseCell
            } else {
                cell = SettingsDefaultTableViewCell(style: .default, reuseIdentifier: "SettingsDefaultCell")
            }

        }

        configureCell(cell: cell, for: indexPath, model: model)

        return cell
    }

    private func configureCell(cell: CustomCellProtocoll, for indexPath: IndexPath, model: SettingsModel) {
        cell.configure(image: model.image, text: model.labelText, isOn: model.isOn, selectedNumber: presenter.getSelectNumber(), closureForAction: model.closureForAction)
        cell.selectionStyle = .none
    }
}

extension SettingsViewController: UITableViewDelegate {
}

extension SettingsViewController: SettingsViewProtocol {
    func changeBackgroundColor(isDark: Bool) {
        guard let window = view.window else {
            return
        }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
            self.view.window?.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
}
