//
//  DeckViewController.swift
//  
//
//  Created by Виктор Борисовский on 23.03.2024.
//

import UIKit
import SystemDesign

final public class DeckViewController: UIViewController {
    private let deckName: String
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        return tableView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .tinted()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    public init(deckName: String) {
        self.deckName = deckName
        
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
        headerLabel.text = "DeckName"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        view.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(headerLabel)
        view.addSubview(plusButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            headerLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -10),
            
            plusButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            plusButton.widthAnchor.constraint(equalToConstant: 46),
            
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension DeckViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Use model count
        5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell else {
            fatalError("No cell with such identifier.")
        }
        
        // TODO: Use model values
        let model = CardCellModel(titleText: "CardName")
        cell.configure(with: model)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    // MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        var actions = [UIContextualAction]()

        let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self] (contextualAction, view, completion) in
            completion(true)
            // TODO: Add functionality
        }
        
        let editAction = UIContextualAction(style: .normal, title: nil) { [weak self] (contextualAction, view, completion) in
            completion(true)
            // TODO: Add functionality
        }

        let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0, weight: .bold, scale: .large)
        
        deleteAction.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed, 50)
        deleteAction.backgroundColor = BaseColorScheme.backgroundColor.resolve().withAlphaComponent(0)

        actions.append(deleteAction)
        
        editAction.image = UIImage(systemName: "pencil", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemOrange, 50)
        editAction.backgroundColor = BaseColorScheme.backgroundColor.resolve().withAlphaComponent(0)

        actions.append(editAction)

        let config = UISwipeActionsConfiguration(actions: actions)
        config.performsFirstActionWithFullSwipe = false

        return config
    }
}


private extension UIImage {
    func addBackgroundCircle(_ color: UIColor?, _ diameter: Double) -> UIImage? {
        let circleDiameter = diameter
        let circleRadius = circleDiameter * 0.5
        let circleSize = CGSize(width: circleDiameter, height: circleDiameter)
        let circleFrame = CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height)
        let imageFrame = CGRect(x: circleRadius - (size.width * 0.5), y: circleRadius - (size.height * 0.5), width: size.width, height: size.height)

        let view = UIView(frame: circleFrame)
        view.backgroundColor = color ?? .systemRed
        view.layer.cornerRadius = circleDiameter * 0.5

        UIGraphicsBeginImageContextWithOptions(circleSize, false, UIScreen.main.scale)

        let renderer = UIGraphicsImageRenderer(size: circleSize)
        let circleImage = renderer.image { ctx in
            view.drawHierarchy(in: circleFrame, afterScreenUpdates: true)
        }

        circleImage.draw(in: circleFrame, blendMode: .normal, alpha: 1.0)
        draw(in: imageFrame, blendMode: .normal, alpha: 1.0)

        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }
}

