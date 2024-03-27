import UIKit
import SystemDesign

public final class AuthViewController: UIViewController {

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
        label.text = "Authorization"
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let additionalTextLabel: UILabel = {
        var label = UILabel()
        label.text = "Enter your email and password"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
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
        return textField
    }()

    private let passwordTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()

    private let continueButton: DefaultButton = {
        var button = DefaultButton(text: "Continue", color: BaseColorScheme.accent)
        return button
    }()

    private var topAnchorOfAuthLabel: NSLayoutConstraint?
    private var topAnchorOfAdditionalTextLabel: NSLayoutConstraint?
    private var topAnchorOfEmailTextField: NSLayoutConstraint?
    private var topAnchorOfContinueButton: NSLayoutConstraint?
    private var bottomAnchorofContinueButton: NSLayoutConstraint?

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubViews()
        setupViews()
        hideKeyboardWhenTappedAround()
        addObservers()
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

    private func hideKeyboard() {
        view.endEditing(true)
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
