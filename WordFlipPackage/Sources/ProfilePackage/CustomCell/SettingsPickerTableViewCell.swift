import UIKit
import SystemDesign

final class SettingsPickerTableViewCell: UITableViewCell, CustomCellProtocoll {

    private let pickerData: [Int]

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, data: [Int]) {
        pickerData = data
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        contentView.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        contentView.addSubview(label)
        contentView.addSubview(pickerView)

        pickerView.delegate = self
        pickerView.dataSource = self

        NSLayoutConstraint.activate([
            pickerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            pickerView.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            pickerView.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            pickerView.heightAnchor.constraint(equalToConstant: 80),

            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: pickerView.leadingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }

    func configure(image: UIImage?, text: String?, isOn: Bool, selectedNumber: Int?, closureForAction: ((Int) -> Void)?) {
        label.text = text
    }
}

extension SettingsPickerTableViewCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

}

extension SettingsPickerTableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}
