import UIKit
import SystemDesign
import Models

final class DeckView: UIView {

    private var deckNamePlaceholderText = "TypeDeckName...".localized
    private var deckNamePlaceholderColor = UIColor.lightGray.withAlphaComponent(0.4)

    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 35, weight: .bold)
        textView.isScrollEnabled = false
        textView.autocorrectionType = .no
        textView.layer.cornerRadius = 8
        textView.textColor = .white
        return textView
    }()

    private let wordCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = BaseColorScheme.buttonText.resolve()
        return label
    }()

    private let learnedWordCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = BaseColorScheme.buttonText.resolve()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        layer.shadowColor = BaseColorScheme.shadowColor.resolve().cgColor
        layer.shadowOffset = ComponentMetrics.shadowOffset
        layer.shadowOpacity = ComponentMetrics.shadowOpacity
        layer.shadowRadius = ComponentMetrics.shadowRadius
        layer.masksToBounds = false

        backgroundColor = #colorLiteral(red: 0.1850751638, green: 0.4414822459, blue: 0.742457211, alpha: 1)

        addSubview(nameTextView)
        addSubview(wordCounterLabel)
        addSubview(learnedWordCounterLabel)

        NSLayoutConstraint.activate([
            nameTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            nameTextView.bottomAnchor.constraint(equalTo: wordCounterLabel.topAnchor, constant: -5),

            wordCounterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            wordCounterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            wordCounterLabel.bottomAnchor.constraint(equalTo: learnedWordCounterLabel.topAnchor),

            learnedWordCounterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            learnedWordCounterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            learnedWordCounterLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }

    func configure(with model: DeckModel, isEditable: Bool = false) {
        let learned = "Learned".localized
        let words = "words".localized
        nameTextView.text = model.name
        wordCounterLabel.text = "\(model.wordCounter) \(words)"
        learnedWordCounterLabel.text = "\(learned) \(model.learnedWordCounter) \(words)"
        nameTextView.isEditable = isEditable
        nameTextView.backgroundColor = isEditable ? #colorLiteral(red: 0.8634499907, green: 0.9234817028, blue: 0.9867377877, alpha: 1) : #colorLiteral(red: 0.1850751638, green: 0.4414822459, blue: 0.742457211, alpha: 1)
        if isEditable {
            nameTextView.delegate = self
            nameTextView.textColor = #colorLiteral(red: 0.1850751638, green: 0.4414822459, blue: 0.742457211, alpha: 1)

            if nameTextView.text.isEmpty {
                nameTextView.text = deckNamePlaceholderText
                nameTextView.font = .systemFont(ofSize: 35, weight: .regular)
                nameTextView.textColor = deckNamePlaceholderColor
            }
        }
    }
    
    func getDeckName() -> String {
        if nameTextView.text == deckNamePlaceholderText {
            return ""
        }
        
        return nameTextView.text
    }
}

extension DeckView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == deckNamePlaceholderColor {
            textView.text = ""
            textView.font = .systemFont(ofSize: 35, weight: .bold)
            textView.textColor = #colorLiteral(red: 0.1850751638, green: 0.4414822459, blue: 0.742457211, alpha: 1)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = deckNamePlaceholderText
            textView.font = .systemFont(ofSize: 35, weight: .regular)
            textView.textColor = deckNamePlaceholderColor
        }
    }
}
