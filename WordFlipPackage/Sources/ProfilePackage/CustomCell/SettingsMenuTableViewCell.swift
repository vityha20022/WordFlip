import UIKit
import SystemDesign

final class SettingsMenuTableViewCell: UITableViewCell, CustomCellProtocoll {

    private let data: [Int]
    private var menuActionClosure: ((Int) -> Void)?

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private let numberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsMenuAsPrimaryAction = true
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(BaseColorScheme.accent.resolve(), for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 7
        return button
    }()

    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, data: [Int]) {
        self.data = data
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        contentView.addSubview(label)
        contentView.addSubview(numberButton)

        configureNumberButton()

        NSLayoutConstraint.activate([
            numberButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            numberButton.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            numberButton.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            numberButton.heightAnchor.constraint(equalToConstant: 25),

            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: numberButton.leadingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }

    private func configureNumberButton() {
        var menuActions = [UIAction]()

        for number in data {
            let action = UIAction(title: "\(number)", handler: { [weak self] _ in
                self?.numberButton.setTitle("\(number)", for: .normal)
                self?.menuActionClosure?(number)
            })
            menuActions.append(action)
        }

        let menu = UIMenu(title: "Number of words:", children: menuActions)
        numberButton.menu = menu
    }

    func configure(image: UIImage?, text: String?, isOn: Bool, selectedNumber: Int?, closureForAction: ((Int) -> Void)?) {
        label.text = text
        numberButton.setTitle(String(selectedNumber ?? 0), for: .normal)
        menuActionClosure = closureForAction
    }
}
