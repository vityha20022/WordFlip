//
//  AuthViewController.swift
//  
//
//  Created by Никита Кисляков on 21.03.2024.
//

import UIKit
import SystemDesign

public class AuthViewController: UIViewController {
    
    private var authLabel: UILabel = {
        var label = UILabel()
        label.text = "Авторизация"
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var additionalTextLabel: UILabel = {
        var label = UILabel()
        label.text = "Введите адрес электронной почты и пароль"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var emailTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.placeholder = "Почта"
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.placeholder = "Пароль"
        return textField
    }()
    
    var continueButton: DefaultButton = {
        var button = DefaultButton(text: "Продолжить", color: BaseColorScheme.accent)
        return button
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(authLabel)
        view.addSubview(additionalTextLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(continueButton)
        emailTextFieldSetup()
        authLabelSetup()
        additionalTextLabelSetup()
        passwordTextFieldSetup()
        continueButtonSetup()
    }
    
    func authLabelSetup() {
        authLabel.centerXAnchor.constraint(equalTo:
                                                view.centerXAnchor).isActive = true
        authLabel.bottomAnchor.constraint(equalTo:
                                                view.bottomAnchor,
                                                constant: -650).isActive = true
    }
    
    func additionalTextLabelSetup() {
        additionalTextLabel.centerXAnchor.constraint(equalTo:
                                                view.centerXAnchor).isActive = true
        additionalTextLabel.bottomAnchor.constraint(equalTo:
                                                view.bottomAnchor,
                                                constant: -585).isActive = true
        additionalTextLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    func emailTextFieldSetup() {
        emailTextField.centerXAnchor.constraint(equalTo:
                                                view.centerXAnchor).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo:
                                                view.bottomAnchor,
                                                constant: -530).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func passwordTextFieldSetup() {
        passwordTextField.centerXAnchor.constraint(equalTo:
                                                view.centerXAnchor).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo:
                                                view.bottomAnchor,
                                                constant: -480).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func continueButtonSetup() {
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.centerXAnchor.constraint(equalTo:
                                                view.centerXAnchor).isActive = true
        continueButton.bottomAnchor.constraint(equalTo:
                                                view.bottomAnchor,
                                                constant: -350).isActive = true
        continueButton.widthAnchor.constraint(equalTo:
                                                view.widthAnchor,
                                                constant: -50).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 
                                                65).isActive = true
    }
    
    


}
