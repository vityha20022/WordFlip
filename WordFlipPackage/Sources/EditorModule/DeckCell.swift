//
//  DeckCell.swift
//  
//
//  Created by Виктор Борисовский on 20.03.2024.
//

import UIKit
import SystemDesign

class DeckCell: UITableViewCell {
    static let identifier = "DeckCell"
    
    let cellView: UIView = {
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let wordCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = BaseColorScheme.buttonText.resolve()
        return label
    }()
    
    let wordsLearnedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = BaseColorScheme.buttonText.resolve()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        
        contentView.addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5)
        ])
        
        
        cellView.addSubview(titleLabel)
        cellView.addSubview(wordCounterLabel)
        cellView.addSubview(wordsLearnedLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: wordCounterLabel.topAnchor, constant: -5),
            
            wordCounterLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 30),
            wordCounterLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            wordCounterLabel.bottomAnchor.constraint(equalTo: wordsLearnedLabel.topAnchor),
        
            wordsLearnedLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 30),
            wordsLearnedLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            wordsLearnedLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -20)
        ])
    }
}
