import UIKit

public final class SettingsViewController: UIViewController {
    private let settingsTableView: UITableView = UITableView()
    private let titleLabel = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(settingsTableView)
        view.addSubview(titleLabel)
        
        configureView()
        configureTitleLable()
        configureTableView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureTitleLable() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Settings"
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    private func configureTableView() {
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.backgroundColor = .systemBackground
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CustomCellProtocoll
        
        if indexPath.row == 0 {
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "SettingsSwitchCell") as? SettingsSwitchTableViewCell {
                cell = reuseCell
            } else {
                cell = SettingsSwitchTableViewCell(style: .default, reuseIdentifier: "SettingsSwitchCell")
            }
            
        } else if indexPath.row == 1 {
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "SettingsPickerCell") as? SettingsPickerTableViewCell {
                cell = reuseCell
            } else {
                cell = SettingsPickerTableViewCell(style: .default, reuseIdentifier: "SettingsPickerCell", data: [1, 2, 3, 4, 5])
            }
            
        } else {
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "SettingsDefaultCell") as? SettingsDefaultTableViewCell {
                cell = reuseCell
            } else {
                cell = SettingsDefaultTableViewCell(style: .default, reuseIdentifier: "SettingsDefaultCell")
            }
            
        }
        
        configureCell(cell: &cell, for: indexPath)
        
        return cell
    }
    
    private func configureCell(cell: inout CustomCellProtocoll, for indexPath: IndexPath) {

        if indexPath.row == 0 {
            cell.configure(image: nil, text: "Theme", isOn: false)
        } else if indexPath.row == 1 {
            cell.configure(image: nil, text: "Number of words", isOn: false)
        } else {
            cell.configure(image: UIImage(systemName: "exclamationmark.triangle"), text: "default", isOn: false)
        }
        
        cell.selectionStyle = .none
    }
}

extension SettingsViewController: UITableViewDelegate {
    
}
