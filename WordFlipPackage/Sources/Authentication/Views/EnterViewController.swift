import UIKit
import SystemDesign

public final class EnterViewController: UIViewController {
    
    private let appTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "WordFlip"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let birdImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "Bird")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let registerButton = DefaultButton(text: "Register", color: BaseColorScheme.accent)
    
    private let signInButton: DefaultButton = {
        var button = DefaultButton(text: "Sign in", color: BaseColorScheme.black)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupButtons()
    }
    
    private func setupAppTitleLabel() {
        NSLayoutConstraint.activate(
            [
                appTitleLabel.centerXAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.centerXAnchor
                ),
                appTitleLabel.centerYAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.centerYAnchor,
                    constant: -view.safeAreaLayoutGuide.layoutFrame.height * 0.3
                )
            ]
        )
    }
    
    private func setupBirdImageView() {
        
        NSLayoutConstraint.activate(
            [
                birdImageView.centerXAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.centerXAnchor
                ),
                birdImageView.widthAnchor.constraint(
                    equalToConstant:
                        180
                ),
                birdImageView.heightAnchor.constraint(
                    equalToConstant:
                        180
                ),
                birdImageView.topAnchor.constraint(
                    equalTo:
                        appTitleLabel.safeAreaLayoutGuide.bottomAnchor,
                    constant:
                        20
                )
            ]
        )
    }
    
    private func setupSignInButton() {
        NSLayoutConstraint.activate(
            [
                signInButton.centerXAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.centerXAnchor
                ),
                signInButton.heightAnchor.constraint(
                    equalToConstant:
                        65
                ),
                signInButton.trailingAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.trailingAnchor,
                    constant:
                        -25
                ),
                signInButton.leadingAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.leadingAnchor,
                    constant:
                        25
                ),
                signInButton.bottomAnchor.constraint(
                    equalTo:
                        registerButton.safeAreaLayoutGuide.topAnchor,
                    constant:
                        -10
                )
            ]
        )
    }
    
    private func setupRegisterButton() {
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                registerButton.bottomAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.bottomAnchor,
                    constant:
                        -20
                ),
                registerButton.trailingAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.trailingAnchor,
                    constant:
                        -25
                ),
                registerButton.leadingAnchor.constraint(
                    equalTo:
                        view.safeAreaLayoutGuide.leadingAnchor,
                    constant:
                        25
                ),
                registerButton.heightAnchor.constraint(
                    equalToConstant:
                        65
                )
            ]
        )
    }
    
    private func addSubviews() {
        view.addSubview(appTitleLabel)
        view.addSubview(signInButton)
        view.addSubview(registerButton)
        view.addSubview(birdImageView)
    }
    
    private func setupButtons() {
        setupAppTitleLabel()
        setupSignInButton()
        setupRegisterButton()
        setupBirdImageView()
    }
    
}
