import UIKit
import SystemDesign

public final class EnterViewController: UIViewController, EnterViewProtocol {

    // MARK: Properties
    
    var presenter: EnterScreenPresenterProtocol?

    private let appTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "WordFlip"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
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

    private let registerButton = DefaultButton(text: "Sign up", color: BaseColorScheme.accent)

    private let signInButton: DefaultButton = {
        var button = DefaultButton(text: "Log in", color: BaseColorScheme.black)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    // MARK: Lifecycle
    
    init(presenter: EnterScreenPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        addSubviews()
        setupButtons()
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }

    // MARK: Actions
    
    func showAuthScreen(navDelegate: NavigationProtocol?) {
        navigationController?.pushViewController(AuthBuilder().build(navDelegate: navDelegate), animated: true)
    }
    
    func showRegisterScreen(navDelegate: NavigationProtocol?) {
        navigationController?.pushViewController(RegisterBuilder().build(navDelegate: navDelegate), animated: true)
    }
    
    @objc
    private func didTapSignInButton() {
        presenter?.didTapSignInButton()
    }

    @objc
    private func didTapRegisterButton() {
        presenter?.didTapRegisterButton()
    }

    // MARK: Views setup

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
                ),
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
                ),
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
                ),
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
                ),
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
