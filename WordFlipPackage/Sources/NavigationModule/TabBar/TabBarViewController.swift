import UIKit
import SystemDesign

public protocol TabBarViewControllerProtocol: AnyObject {
    func updateSelected(index: Int)
}

public final class TabBarViewController: UITabBarController, TabBarViewControllerProtocol {
    // MARK: - Properties
    private var presenter: TabBarPresenterProtocol

    private var tabBarViewControllers: [UIViewController]

    private lazy var action = UIAction(handler: { [weak self] sender in
        guard let sender = sender.sender as? UIButton else { return }
        self?.presenter.didTapButton(withTag: sender.tag)
    })

    // MARK: - UI Elements
    private lazy var decksButton = getButton(icon: "menucard.fill", tag: 0, action: action)
    private lazy var cardsButton = getButton(icon: "graduationcap.fill", tag: 1, action: action, opacity: 1)
    private lazy var userButton = getButton(icon: "person.fill", tag: 2, action: action)

    private lazy var stack: UIStackView = {
        let make = UIStackView()
        make.axis = .horizontal
        make.distribution = .equalSpacing
        make.alignment = .center
        make.backgroundColor = BaseColorScheme.backgroundColor.resolve()
        make.layer.shadowColor = BaseColorScheme.shadowColor.resolve().cgColor
        make.layer.shadowOffset = CGSize(width: 0, height: 0)
        make.layer.shadowOpacity = 0.35
        make.layer.shadowRadius = 20
        if UIScreen.main.bounds.width <= 375 {
            make.frame = .init(x: 20, y: view.frame.height - 60, width: view.frame.width - 20 - 20, height: 50)
        } else {
            make.frame = .init(x: 30, y: view.frame.height - 80, width: view.frame.width - 30 - 30, height: 50)
        }
        make.layer.cornerRadius = make.frame.height / 2
        make.addArrangedSubview(UIView())
        make.addArrangedSubview(decksButton)
        make.addArrangedSubview(cardsButton)
        make.addArrangedSubview(userButton)
        make.addArrangedSubview(UIView())
        return make
    }()

    public init(
        decksVC: UIViewController,
        cardsVC: UIViewController,
        userVC: UIViewController,
        presenter: TabBarPresenterProtocol
    ) {
        self.tabBarViewControllers = [decksVC, cardsVC, userVC]
        self.presenter = presenter
        super.init(nibName: "", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stack)
        setupControllers()
    }

    // MARK: - Setup Base UI
    private func setupControllers() {
        userButton.accessibilityIdentifier = "TabbarProfileButtonIdentifier"
        setViewControllers(tabBarViewControllers, animated: false)
        selectedIndex = 1
    }

    private func getButton(icon: String, tag: Int, action: UIAction, opacity: Float = 0.5) -> UIButton {
        let make = UIButton(primaryAction: action)
        make.setImage(UIImage(systemName: icon), for: .normal)
        make.layer.opacity = opacity
        make.tag = tag
        return make
    }

    // MARK: - View Actions
    public func updateSelected(index: Int) {
        self.selectedIndex = index
        setOpacity(tag: index)
    }

    private func setOpacity(tag: Int) {
        [decksButton, cardsButton, userButton] .forEach { button in
            if button.tag != tag {
                button.layer.opacity = 0.5
            } else {
                button.layer.opacity = 1
            }
        }
    }
}
