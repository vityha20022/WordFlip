import UIKit
import MainView
import SystemDesign

final class AuthViewController: UIViewController, AuthViewProtocol {    

    // MARK: Properties

    let presenter: AuthScreenPresenterProtocol

    private let scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let authLabel: UILabel = {
        var label = UILabel()
        label.text = "LogInLabel".localized
        label.font = UIFont.systemFont(ofSize: 45, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let additionalTextLabel: UILabel = {
        var label = UILabel()
        label.text = "EnterYourDataLogIn".localized
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let emailTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        textField.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        return textField
    }()

    private let passwordTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.placeholder = "TextFieldPassword".localized
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textContentType = .password
        textField.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        return textField
    }()

    private let continueButton: DefaultButton = {
        var button = DefaultButton(text: "ContinueButton".localized, color: BaseColorScheme.accent)
        return button
    }()

    private var topAnchorOfAuthLabel: NSLayoutConstraint?
    private var topAnchorOfAdditionalTextLabel: NSLayoutConstraint?
    private var topAnchorOfEmailTextField: NSLayoutConstraint?
    private var topAnchorOfContinueButton: NSLayoutConstraint?
    private var bottomAnchorofContinueButton: NSLayoutConstraint?

    init(presenter: AuthScreenPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        addSubViews()
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

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.topAnchorOfAuthLabel?.constant = -self.contentView.safeAreaLayoutGuide.layoutFrame.height * 0.4
            self.topAnchorOfAdditionalTextLabel?.constant = 20
            self.topAnchorOfEmailTextField?.constant = 30
            self.topAnchorOfContinueButton?.constant = 30
            self.bottomAnchorofContinueButton?.constant = -180
            self.contentView.layoutIfNeeded()
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        self.topAnchorOfAuthLabel?.constant = -self.contentView.safeAreaLayoutGuide.layoutFrame.height * 0.3
        self.topAnchorOfAdditionalTextLabel?.constant = 40
        self.topAnchorOfEmailTextField?.constant = 50
        self.topAnchorOfContinueButton?.constant = 60
        self.bottomAnchorofContinueButton?.constant = -150
        self.contentView.layoutIfNeeded()
    }

    @objc
    private func didTapContinueButton() {
        presenter.auth(email: emailTextField.text, password: passwordTextField.text)
    }

    private func hideKeyboard() {
        view.endEditing(true)
    }

    // MARK: Views setup

    private func setupScrollView() {
        NSLayoutConstraint.activate(
            [
                scrollView.leadingAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.leadingAnchor
                ),
                scrollView.topAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.topAnchor
                ),
                scrollView.trailingAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.trailingAnchor
                ),
                scrollView.bottomAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.bottomAnchor
                ),
            ]
        )
    }

    private func setupContentView() {
        NSLayoutConstraint.activate(
            [
                contentView.leadingAnchor.constraint(
                    equalTo:
                        scrollView.safeAreaLayoutGuide.leadingAnchor
                ),
                contentView.topAnchor.constraint(
                    equalTo:
                        scrollView.safeAreaLayoutGuide.topAnchor
                ),
                contentView.trailingAnchor.constraint(
                    equalTo:
                        scrollView.safeAreaLayoutGuide.trailingAnchor
                ),
                contentView.bottomAnchor.constraint(
                    equalTo:
                        scrollView.safeAreaLayoutGuide.bottomAnchor
                ),
                contentView.widthAnchor.constraint(
                    equalTo:
                        scrollView.safeAreaLayoutGuide.widthAnchor
                ),
                contentView.heightAnchor.constraint(
                    equalTo:
                        scrollView.safeAreaLayoutGuide.heightAnchor
                ),
            ]
        )
    }

    private func authLabelSetup() {
        NSLayoutConstraint.activate(
            [
                authLabel.centerXAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.centerXAnchor
                ),
            ]
        )
        topAnchorOfAuthLabel = authLabel.centerYAnchor.constraint(
            equalTo:
                contentView.safeAreaLayoutGuide.centerYAnchor,
            constant:
                -contentView.safeAreaLayoutGuide.layoutFrame.height * 0.3
        )
        topAnchorOfAuthLabel?.isActive = true
    }

    private func additionalTextLabelSetup() {
        NSLayoutConstraint.activate(
            [
                additionalTextLabel.centerXAnchor.constraint(
                    equalTo:
                        view.centerXAnchor
                ),
                additionalTextLabel.widthAnchor.constraint(
                    equalToConstant: 350
                ),
            ]
        )
        topAnchorOfAdditionalTextLabel = additionalTextLabel.topAnchor.constraint(
            equalTo:
                authLabel.safeAreaLayoutGuide.bottomAnchor,
            constant: 40
        )
        topAnchorOfAdditionalTextLabel?.isActive = true
    }

    private func emailTextFieldSetup() {
        NSLayoutConstraint.activate(
            [
                emailTextField.centerXAnchor.constraint(
                    equalTo:
                        contentView.safeAreaLayoutGuide.centerXAnchor
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
                emailTextField.heightAnchor.constraint(
                    equalToConstant: 40
                ),
            ]
        )
        topAnchorOfEmailTextField = emailTextField.topAnchor.constraint(
            equalTo:
                additionalTextLabel.safeAreaLayoutGuide.bottomAnchor,
            constant: 50
        )
        topAnchorOfEmailTextField?.isActive = true
    }

    private func passwordTextFieldSetup() {
        NSLayoutConstraint.activate(
            [
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
                passwordTextField.heightAnchor.constraint(
                    equalToConstant: 40
                ),
                passwordTextField.topAnchor.constraint(
                    equalTo:
                        emailTextField.safeAreaLayoutGuide.bottomAnchor,
                    constant: 10
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
                    equalToConstant: 65
                ),
            ]
        )
        bottomAnchorofContinueButton = continueButton.bottomAnchor.constraint(
            lessThanOrEqualTo:
                contentView.safeAreaLayoutGuide.bottomAnchor,
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
        setupScrollView()
        setupContentView()
        authLabelSetup()
        additionalTextLabelSetup()
        emailTextFieldSetup()
        passwordTextFieldSetup()
        continueButtonSetup()
    }

    private func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(authLabel)
        contentView.addSubview(additionalTextLabel)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(continueButton)
    }
}

extension AuthViewController: UITextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }

}

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
