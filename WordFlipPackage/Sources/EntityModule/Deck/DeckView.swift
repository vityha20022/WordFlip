//
//  DeckView.swift
//  
//
//  Created by Виктор Борисовский on 24.03.2024.
//

import UIKit
import SystemDesign
import Models

class DeckView: UIView {
    private var deckNamePlaceholderText = "Type deck name..."
    private var deckNamePlaceholderColor = UIColor.lightGray
    
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 25, weight: .bold)
        textView.isScrollEnabled = false
        textView.autocorrectionType = .no
        textView.layer.cornerRadius = 15
        textView.textColor = .white
        return textView
    }()
    
    private let wordCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = BaseColorScheme.buttonText.resolve()
        return label
    }()
    
    private let learnedWordCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
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
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 15
        self.layer.shadowColor = BaseColorScheme.shadowColor.resolve().cgColor
        self.layer.shadowOffset = ComponentMetrics.shadowOffset
        self.layer.shadowOpacity = ComponentMetrics.shadowOpacity
        self.layer.shadowRadius = ComponentMetrics.shadowRadius
        self.layer.masksToBounds = false
        
        self.backgroundColor = BaseColorScheme.accent.resolve()
        
        self.addSubview(nameTextView)
        self.addSubview(wordCounterLabel)
        self.addSubview(learnedWordCounterLabel)
        
        NSLayoutConstraint.activate([
            nameTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            nameTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            nameTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            nameTextView.bottomAnchor.constraint(equalTo: wordCounterLabel.topAnchor, constant: -5),
            
            wordCounterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            wordCounterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            wordCounterLabel.bottomAnchor.constraint(equalTo: learnedWordCounterLabel.topAnchor),
        
            learnedWordCounterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            learnedWordCounterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            learnedWordCounterLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with model: DeckModel, isEditable: Bool = false) {
        nameTextView.text = model.name
        wordCounterLabel.text = "\(model.wordCounter) words"
        learnedWordCounterLabel.text = "Learned \(model.learnedWordCounter) words"
        nameTextView.isEditable = isEditable
        nameTextView.backgroundColor = isEditable ?  .white : BaseColorScheme.accent.resolve()
        if isEditable {
            nameTextView.delegate = self
            nameTextView.textColor = .black
            
            if nameTextView.text.isEmpty {
                nameTextView.text = deckNamePlaceholderText
                nameTextView.textColor = deckNamePlaceholderColor
            }
        }
    }
}

extension DeckView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == deckNamePlaceholderColor {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = deckNamePlaceholderText
            textView.textColor = .lightGray
        }
    }
}
