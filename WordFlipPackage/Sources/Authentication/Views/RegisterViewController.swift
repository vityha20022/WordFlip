import UIKit
import EntityModule
import SystemDesign
import MainView

final class RegisterViewController: UIViewController, RegisterViewProtocol {

    // MARK: Properties

    let presenter: RegisterScreenPresenterProtocol

    private let contentView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let registerLabel: UILabel = {
        var label = UILabel()
        label.text = "SignUpButton".localized
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let additionalTextLabel: UILabel = {
        var label = UILabel()
        label.text = "SignUpEnterYourData".localized
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let usernameTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.placeholder = "UsernameTextLabel".localized
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()

    private let emailTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        return textField
    }()

    private let passwordTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.placeholder = "TextFieldPassword".localized
        textField.isSecureTextEntry = true
        textField.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textContentType = .password
        return textField
    }()

    private let continueButton: DefaultButton = {
        var button = DefaultButton(text: "ContinueButton".localized, color: BaseColorScheme.accent)
        return button
    }()

    private var topAnchorOfRegisterLabel: NSLayoutConstraint?
    private var topAnchorOfAdditionalTextLabel: NSLayoutConstraint?
    private var topAnchorOfUsernameTextField: NSLayoutConstraint?
    private var topAnchorOfContinueButton: NSLayoutConstraint?
    private var bottomAnchorofContinueButton: NSLayoutConstraint?

    // MARK: Lifecycle
    
    init(presenter: RegisterScreenPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        emailTextField.delegate = self
        view.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        addSubviews()
        setupViews()
        hideKeyboardWhenTappedAround()
        addObservers()
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
    }

    // MARK: Actions

    public func showErrorAlert(error: String) {
        let alert = UIAlertController(title: "smthWrong".localized, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func hideKeyboard() {
        view.endEditing(true)
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.topAnchorOfRegisterLabel?.constant = -self.contentView.safeAreaLayoutGuide.layoutFrame.height * 0.48
            self.topAnchorOfAdditionalTextLabel?.constant = 10
            self.topAnchorOfUsernameTextField?.constant = 30
            self.topAnchorOfContinueButton?.constant = 30
            self.bottomAnchorofContinueButton?.constant = -180
            self.contentView.layoutIfNeeded()
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        self.topAnchorOfRegisterLabel?.constant = -self.contentView.safeAreaLayoutGuide.layoutFrame.height * 0.34
        self.topAnchorOfAdditionalTextLabel?.constant = 40
        self.topAnchorOfUsernameTextField?.constant = 50
        self.topAnchorOfContinueButton?.constant = 60
        self.bottomAnchorofContinueButton?.constant = -150
        self.contentView.layoutIfNeeded()
    }

    @objc
    private func didTapContinueButton() {
        presenter.register(username: usernameTextField.text, email: emailTextField.text, password: passwordTextField.text)
    }

  // MARK: setting contraints

    private func setupContentView() {
        NSLayoutConstraint.activate(
            [
                contentView.leadingAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.leadingAnchor
                ),
                contentView.topAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.topAnchor
                ),
                contentView.trailingAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.trailingAnchor
                ),
                contentView.bottomAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.bottomAnchor
                ),
                contentView.widthAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.widthAnchor
                ),
                contentView.heightAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.heightAnchor
                ),
            ]
        )
    }

    private func registerLabelSetup() {
        registerLabel.centerXAnchor.constraint(
            equalTo:
                contentView.safeAreaLayoutGuide.centerXAnchor
        ).isActive = true
        topAnchorOfRegisterLabel = registerLabel.centerYAnchor.constraint(
            equalTo:
                contentView.safeAreaLayoutGuide.centerYAnchor,
            constant:
                -contentView.safeAreaLayoutGuide.layoutFrame.height * 0.3
        )
        topAnchorOfRegisterLabel?.isActive = true
    }

    private func additionalTextLabelSetup() {
        NSLayoutConstraint.activate(
            [
                additionalTextLabel.trailingAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.trailingAnchor,
                    constant: -20
                ),
                additionalTextLabel.leadingAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.leadingAnchor,
                    constant: 20
                ),
            ]
        )

        topAnchorOfAdditionalTextLabel = additionalTextLabel.topAnchor.constraint(
            equalTo:
                registerLabel.bottomAnchor,
            constant: 40
        )
        topAnchorOfAdditionalTextLabel?.isActive = true
    }

    private func usernameTextFieldSetup() {
        NSLayoutConstraint.activate(
            [
                usernameTextField.trailingAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.trailingAnchor,
                    constant: -40
                ),
                usernameTextField.leadingAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.leadingAnchor,
                    constant: 40
                ),
            ]
        )

        topAnchorOfUsernameTextField = usernameTextField.topAnchor.constraint(
            equalTo:
                additionalTextLabel.safeAreaLayoutGuide.bottomAnchor,
            constant: 50
        )
        topAnchorOfUsernameTextField?.isActive = true
    }

    private func emailTextFieldSetup() {
        NSLayoutConstraint.activate(
            [
                emailTextField.topAnchor.constraint(
                    equalTo:
                        usernameTextField.safeAreaLayoutGuide.bottomAnchor,
                    constant: 10
                ),
                emailTextField.trailingAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.trailingAnchor,
                    constant: -40
                ),
                emailTextField.leadingAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.leadingAnchor,
                    constant: 40
                ),
            ]
        )
    }

    private func passwordTextFieldSetup() {
        NSLayoutConstraint.activate(
            [
                passwordTextField.topAnchor.constraint(
                    equalTo:
                        emailTextField.safeAreaLayoutGuide.bottomAnchor,
                    constant: 10
                ),
                passwordTextField.trailingAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.trailingAnchor,
                    constant: -40
                ),
                passwordTextField.leadingAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.leadingAnchor,
                    constant: 40
                ),
            ]
        )
    }

    private func continueButtonSetup() {
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                continueButton.trailingAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.trailingAnchor,
                    constant: -25
                ),
                continueButton.leadingAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.leadingAnchor,
                    constant: 25
                ),
                continueButton.heightAnchor.constraint(
                    equalToConstant:
                        65
                ),
            ]
        )
        bottomAnchorofContinueButton = continueButton.bottomAnchor.constraint(
            lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor,
            constant: -150
        )
        bottomAnchorofContinueButton?.isActive = true
        bottomAnchorofContinueButton?.priority = .defaultLow
        topAnchorOfContinueButton = continueButton.topAnchor.constraint(
            equalTo:
                passwordTextField.safeAreaLayoutGuide.bottomAnchor,
            constant: 60
        )
        topAnchorOfContinueButton?.isActive = true
    }

    private func setupViews() {
        setupContentView()
        registerLabelSetup()
        additionalTextLabelSetup()
        usernameTextFieldSetup()
        emailTextFieldSetup()
        passwordTextFieldSetup()
        continueButtonSetup()
    }

    private func addSubviews() {
        view.addSubview(contentView)
        contentView.addSubview(registerLabel)
        contentView.addSubview(additionalTextLabel)
        contentView.addSubview(usernameTextField)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(continueButton)
    }
}

extension RegisterViewController: UITextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }

}
