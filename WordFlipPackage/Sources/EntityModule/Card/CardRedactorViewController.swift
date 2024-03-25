//
//  CardRedactorViewController.swift
//  
//
//  Created by Виктор Борисовский on 25.03.2024.
//

import UIKit
import SystemDesign
import Models

public struct CardRedactorConfiguration {
    let title: String
    let model: CardModel
    
    public init(title: String, model: CardModel) {
        self.title = title
        self.model = model
    }
}

final public class CardRedactorViewController: UIViewController {
    private let configuration: CardRedactorConfiguration
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let frontSideCardView: CardView = {
        return CardView(for: .front)
    }()
    
    private let downSideCardView: CardView = {
        return CardView(for: .down)
    }()
    
    private let translateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .tinted()
        button.setTitle("Translate", for: .normal)
        return button
    }()
    
    public init(with configuration: CardRedactorConfiguration) {
        self.configuration = configuration
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        hideKeyboardWhenTappedAround()
        
        frontSideCardView.configure(with: configuration.model)
        downSideCardView.configure(with: configuration.model)
        
        view.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        
        headerLabel.text = configuration.title
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(headerLabel)
        view.addSubview(frontSideCardView)
        view.addSubview(translateButton)
        view.addSubview(downSideCardView)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            headerLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            
            translateButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            translateButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            
            frontSideCardView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            frontSideCardView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            frontSideCardView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            frontSideCardView.bottomAnchor.constraint(equalTo: downSideCardView.topAnchor, constant: -10),
            
            downSideCardView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            downSideCardView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            downSideCardView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            
            frontSideCardView.heightAnchor.constraint(equalTo: downSideCardView.heightAnchor)
        ])
    }
}
