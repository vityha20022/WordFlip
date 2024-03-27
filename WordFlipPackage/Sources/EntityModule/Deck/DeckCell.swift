import UIKit
import SystemDesign
import Models

struct DeckCellModel {
    let titleText: String
    let wordCounterText: String
    let wordsLearnedText: String
}

final class DeckCell: UITableViewCell {
    static let identifier = "DeckCell"

    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.shadowColor = BaseColorScheme.shadowColor.resolve().cgColor
        view.layer.shadowOffset = ComponentMetrics.shadowOffset
        view.layer.shadowOpacity = ComponentMetrics.shadowOpacity
        view.layer.shadowRadius = ComponentMetrics.shadowRadius
        view.layer.masksToBounds = false

        view.backgroundColor = BaseColorScheme.accent.resolve()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let wordCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = BaseColorScheme.buttonText.resolve()
        return label
    }()

    private let deckView = DeckView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: DeckModel) {
        deckView.configure(with: model)
    }

    private func setup() {
        contentView.backgroundColor = BaseColorScheme.backgroundColor.resolve()

        contentView.addSubview(deckView)

        NSLayoutConstraint.activate([
            deckView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            deckView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            deckView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            deckView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}
