import UIKit

final class SettingsSwitchTableViewCell: UITableViewCell, CustomCellProtocoll {

    private var switchStateChangedHandler: ((Int) -> Void)?

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private let switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        return switchView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        contentView.addSubview(label)
        contentView.addSubview(switchView)

        NSLayoutConstraint.activate([
            switchView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            switchView.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            switchView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            switchView.heightAnchor.constraint(equalToConstant: 20),

            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: switchView.leadingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }

    func configure(image: UIImage?, text: String?, isOn: Bool, selectedNumber: Int?, closureForAction: ((Int) -> Void)?) {
        label.text = text
        switchView.isOn = isOn

        switchStateChangedHandler = closureForAction

        switchView.removeTarget(nil, action: nil, for: .allEvents)

        switchView.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.switchStateChangedHandler?(self.switchView.isOn ? 1 : 0)
        }, for: .valueChanged)
    }
}
