import UIKit

final public class TabBarViewController: UITabBarController {
    var vc: UIViewController? = nil
    public init(vc: UIViewController?){
        self.vc = vc
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var myTabBar = TabBar()
    
    lazy var deckButton = getButton(icon: "doc.questionmark.fill.rtl", tag: 0, action: action)
    lazy var mainButton = getButton(icon: "graduationcap.fill", tag: 1, action: action, opacity: 1)
    lazy var userButton = getButton(icon: "person.fill", tag: 2, action: action)
    
    private lazy var stack: UIStackView = {
        let make = UIStackView()
        make.axis = .horizontal
        make.distribution = .equalSpacing
        make.alignment = .center
        make.backgroundColor = .white
        make.layer.shadowOffset = CGSize(width: 0, height: 0)
        make.layer.shadowOpacity = 0.35
        make.layer.shadowRadius = 20
        if UIScreen.main.bounds.width <= 375 {
            make.frame = .init(x: 20, y: view.frame.height - 60, width: view.frame.width - 20 - 20, height: 50)
        }else{
            make.frame = .init(x: 30, y: view.frame.height - 80, width: view.frame.width - 30 - 30, height: 50)
        }
        make.layer.cornerRadius = make.frame.height / 2
        make.addArrangedSubview(UIView())
        make.addArrangedSubview(deckButton)
        make.addArrangedSubview(mainButton)
        make.addArrangedSubview(userButton)
        make.addArrangedSubview(UIView())
        return make
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setValue(myTabBar, forKey: "tabBar")
        view.addSubview(stack)
        setupControllers()
    }
    
    private func setupControllers() {
        let deckVC = UIViewController()
        var mainVC = UIViewController()
        if vc != nil {
            mainVC = vc!
        }
        let userVC = UIViewController()

        setViewControllers([deckVC, mainVC, userVC], animated: false)
        
        selectedIndex = 1
    }
    
    private func getButton(icon: String, tag: Int, action: UIAction, opacity: Float = 0.5) -> UIButton {
        let make = UIButton(primaryAction: action)
        make.setImage(UIImage(systemName: icon), for: .normal)
        make.tintColor = .black
        make.layer.opacity = opacity
        make.tag = tag
        return make
    }
    
    lazy var action = UIAction(handler: { [weak self] sender in
        guard 
            let sender = sender.sender as? UIButton,
            let self = self
        else { return }
        
        self.selectedIndex = sender.tag
        setOpacity(tag: sender.tag)
        
    })
    
    
    private func setOpacity(tag: Int) {
        [deckButton, mainButton, userButton] .forEach { button in
            if button.tag != tag {
                button.layer.opacity = 0.5
            } else{
                button.layer.opacity = 1
            }
        }
    }
    
}
