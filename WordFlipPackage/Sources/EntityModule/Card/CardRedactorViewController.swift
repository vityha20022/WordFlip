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
    private let languageData = ["English", "Russian", "Germany"]
    
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
    
    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsMenuAsPrimaryAction = true
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(BaseColorScheme.accent.resolve(), for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 7
        
        var menuActions = [UIAction]()
        
        for language in languageData {
            let action = UIAction(title: "\(language)", handler: { [self] _ in
                button.setTitle("\(language)", for: .normal)
            })
            menuActions.append(action)
        }
        
        let menu = UIMenu(title: "Source language:", children: menuActions)
        button.menu = menu
        button.setTitle(languageData[0], for: .normal)
        
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsMenuAsPrimaryAction = true
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(BaseColorScheme.accent.resolve(), for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 7
        
        var menuActions = [UIAction]()
        
        for language in languageData {
            let action = UIAction(title: "\(language)", handler: { [self] _ in
                button.setTitle("\(language)", for: .normal)
            })
            menuActions.append(action)
        }
        
        let menu = UIMenu(title: "Target language:", children: menuActions)
        button.menu = menu
        button.setTitle(languageData[1], for: .normal)
        
        return button
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.forward"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        view.addSubview(sourceLanguageButton)
        view.addSubview(arrowImageView)
        view.addSubview(targetLanguageButton)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: ComponentMetrics.headerTitleTopMargin),
            headerLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            
            translateButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            translateButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            
            sourceLanguageButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            sourceLanguageButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            sourceLanguageButton.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -5),
            
            
            arrowImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 30),
            arrowImageView.heightAnchor.constraint(equalToConstant: 30),
            arrowImageView.centerYAnchor.constraint(equalTo: targetLanguageButton.centerYAnchor),
            
            targetLanguageButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            targetLanguageButton.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: 5),
            targetLanguageButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            
            frontSideCardView.topAnchor.constraint(equalTo: sourceLanguageButton.bottomAnchor, constant: 20),
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
