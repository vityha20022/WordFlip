import UIKit
import WordFlipPackage

public class TabBarViewController: UITabBarController {
    
    private let myTabBar = TabBar()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setValue(myTabBar, forKey: "tabBar")
        setupTapItems()
    }
    
    private func setupTapItems() {
        let firstVC = ViewController()
        firstVC.tabBarItem.title = "first"
        firstVC.tabBarItem.image = UIImage(systemName: "graduationcap.fill")
        let secondVC = ViewController()
        secondVC.tabBarItem.title = "second"
        secondVC.tabBarItem.image = UIImage(systemName: "doc.questionmark.fill.rtl")
        let thridVC = ViewController()
        thridVC.tabBarItem.title = "thrid"
        thridVC.tabBarItem.image = UIImage(systemName: "person.fill")
        
        setViewControllers([firstVC, secondVC, thridVC], animated: false)
        
        selectedIndex = 1
    }
}
