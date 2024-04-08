import UIKit
import SystemDesign
import Models

final class CardCell: UITableViewCell {
    static let identifier = "CardCell"

    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.shadowColor = BaseColorScheme.shadowColor.resolve().cgColor
        view.layer.shadowOffset = ComponentMetrics.shadowOffset
        view.layer.shadowOpacity = ComponentMetrics.shadowOpacity
        view.layer.shadowRadius = ComponentMetrics.shadowRadius
        view.layer.masksToBounds = false

        view.backgroundColor = BaseColorScheme.frontSideCardColor.resolve()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = BaseColorScheme.downSideCardColor.resolve()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: CardModel) {
        titleLabel.text = model.frontText
    }

    private func setup() {
        contentView.backgroundColor = BaseColorScheme.backgroundColor.resolve()

        contentView.addSubview(cellView)
        cellView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -25),
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 25),
            titleLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -25),
        ])
    }

}
