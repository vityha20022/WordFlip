//
//  CardView.swift
//  
//
//  Created by Виктор Борисовский on 25.03.2024.
//

import UIKit
import SystemDesign
import Models

public enum CardSide {
    case front
    case down
}

final class CardView: UIView {
    private let cardNamePlaceholderText: String
    private let cardColor: UIColor
    private let cardTextColor: UIColor
    private let cardSide: CardSide
    private let cardNamePlaceholderColor = UIColor.lightGray
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 25, weight: .bold)
        //textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.autocorrectionType = .no
        textView.layer.cornerRadius = 15
        textView.textColor = .white
        return textView
    }()
    
    init(for side: CardSide) {
        switch side {
            case .front:
                cardNamePlaceholderText = "Type word..."
                cardColor = BaseColorScheme.frontSideCardColor.resolve()
                cardTextColor = BaseColorScheme.downSideCardColor.resolve()
            case .down:
                cardNamePlaceholderText = "Type tip..."
                cardColor = BaseColorScheme.downSideCardColor.resolve()
                cardTextColor = BaseColorScheme.frontSideCardColor.resolve()
        }
        
        cardSide = side
        
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textView.centerVertically()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 35
        self.layer.shadowColor = BaseColorScheme.shadowColor.resolve().cgColor
        self.layer.shadowOffset = ComponentMetrics.shadowOffset
        self.layer.shadowOpacity = ComponentMetrics.shadowOpacity
        self.layer.shadowRadius = ComponentMetrics.shadowRadius
        self.layer.masksToBounds = false
        
        self.backgroundColor = cardColor
        
        self.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            textView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    func configure(with model: CardModel) {
        switch cardSide {
            case .front:
                textView.text = model.frontText
                textView.textColor = BaseColorScheme.downSideCardColor.resolve()
            case .down:
                textView.text = model.downText
                textView.textColor = BaseColorScheme.frontSideCardColor.resolve()
        }
        
        textView.backgroundColor = cardColor
        textView.delegate = self
        
        if textView.text.isEmpty {
            textView.text = cardNamePlaceholderText
            textView.textColor = cardNamePlaceholderColor
        }
    }
}

extension CardView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == cardNamePlaceholderColor {
            textView.text = ""
            textView.textColor = cardTextColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = cardNamePlaceholderText
            textView.textColor = .lightGray
        }
    }
}

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(0, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
