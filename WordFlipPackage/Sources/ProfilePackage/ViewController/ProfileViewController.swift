import UIKit
import SystemDesign

public final class ProfileViewController: UIViewController {
    
    private let profileTableView: UITableView = UITableView()
    private let exitButton = DefaultButton(text: "Выход", color: BaseColorScheme.red)
    private let titleLabel = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(exitButton)
        view.addSubview(profileTableView)
        view.addSubview(titleLabel)
        
        configureView()
        configureExitButton()
        configureTableView()
        configureTitleLable()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureExitButton() {
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            exitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            exitButton.heightAnchor.constraint(equalToConstant: 65),
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
           
        ])
    }
    
    private func configureTitleLable() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Profile"
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])

    }
    
    private func configureTableView() {
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.backgroundColor = .systemBackground
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.separatorStyle = .none

        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: exitButton.topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
        
        configureCell(cell: &cell, for: indexPath)
        isScrollEnabled()
        
        return cell
        
    }
    
    private func configureCell(cell: inout CustomCellProtocoll, for indexPath: IndexPath) {

        if indexPath.row == 0 {
            cell.configure(image: UIImage(systemName: "person.crop.circle"), text: "br_zahar", isOn: nil)
        } else if indexPath.row == 1 {
            cell.configure(image: UIImage(systemName: "gear"), text: "Settings", isOn: nil)
        } else if indexPath.row == 2 {
            cell.configure(image: UIImage(systemName: "info.circle"), text: "About the program", isOn: nil)
        } else {
            cell.configure(image: UIImage(systemName: "exclamationmark.triangle"), text: "default", isOn: nil)
        }
        
        cell.selectionStyle = .none
    }
    
    private func isScrollEnabled() {
        if profileTableView.contentSize.height <= profileTableView.bounds.size.height {
            profileTableView.isScrollEnabled = false
        } else {
            profileTableView.isScrollEnabled = true
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate {
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard indexPath.row != 0 else { return }
//            tableView.deselectRow(at: indexPath, animated: true)
//    }
}
