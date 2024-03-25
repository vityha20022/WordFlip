import UIKit

public struct SettingsBuilder {
    
    public init() {
    }
    
    public func build() -> UIViewController {
        let presentor = SettingsPresenter()
        let settingsViewController = SettingsViewController(presenter: presentor)
        presentor.settingsView = settingsViewController
        return settingsViewController
    }
}
