import UIKit

public struct SettingsBuilder {

    public init() {
    }

    public func build() -> UIViewController {
        let presenter = SettingsPresenter()
        let settingsViewController = SettingsViewController(presenter: presenter)
        presenter.settingsView = settingsViewController
        return settingsViewController
    }
}
