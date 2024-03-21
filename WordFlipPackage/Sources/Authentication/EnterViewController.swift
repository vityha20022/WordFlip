//
//  AuthViewController.swift
//  
//
//  Created by Никита Кисляков on 20.03.2024.
//

import UIKit
import SystemDesign

public class EnterViewController: UIViewController {
    
    var appTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "WordFlip"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var birdImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Bird")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var registerButton = DefaultButton(text: "Зарегистрироваться", color: BaseColorScheme.accent)
        
    var signInButton: DefaultButton = {
        var button = DefaultButton(text: "Войти", color: BaseColorScheme.black)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        addLayout()
        setupButtons()
    }
    
    func setupAppTitleLabel() {
        appTitleLabel.centerXAnchor.constraint(equalTo: 
                                                view.centerXAnchor).isActive = true
        appTitleLabel.bottomAnchor.constraint(equalTo: 
                                                view.bottomAnchor,
                                                constant: -500).isActive = true
    }
    
    func setupBirdImageView() {
        birdImageView.centerXAnchor.constraint(equalTo: 
                                                view.centerXAnchor).isActive = true
        birdImageView.widthAnchor.constraint(equalToConstant: 
                                                180).isActive = true
        birdImageView.heightAnchor.constraint(equalToConstant: 
                                                180).isActive = true
        birdImageView.centerYAnchor.constraint(equalTo: 
                                                view.centerYAnchor,
                                                constant: 28).isActive = true
    }
    
    func setupsignInButton() {
        signInButton.centerXAnchor.constraint(equalTo:
                                                view.centerXAnchor).isActive = true
        signInButton.bottomAnchor.constraint(equalTo:
                                                view.bottomAnchor,
                                                constant: -140).isActive = true
        signInButton.widthAnchor.constraint(equalTo:
                                                view.widthAnchor,
                                                constant: -50).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant:
                                                65).isActive = true
    }
    
    func setupRegisterButton() {
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.centerXAnchor.constraint(equalTo:
                                                view.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo:
                                                view.bottomAnchor,
                                                constant: -60).isActive = true
        registerButton.widthAnchor.constraint(equalTo:
                                                view.widthAnchor,
                                                constant: -50).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant:
                                                65).isActive = true
    }
    
    func addLayout() {
        view.addSubview(appTitleLabel)
        view.addSubview(signInButton)
        view.addSubview(registerButton)
        view.addSubview(birdImageView)
    }
    
    func setupButtons() {
        setupAppTitleLabel()
        setupsignInButton()
        setupRegisterButton()
        setupBirdImageView()
    }
    
    
}

