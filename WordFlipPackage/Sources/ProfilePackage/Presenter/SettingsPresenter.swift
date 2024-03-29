import UIKit

final class SettingsPresenter: SettingsPresenterProtocol {

    weak var settingsView: SettingsViewProtocol!
    lazy var arraySettings = [
        SettingsModel(image: nil, labelText: "NightTheme".localized, isOn: switchDark(), data: []) { [weak settingsView] resultNumber in
            UserDefaults.standard.set(resultNumber == 1, forKey: "NightThemeSwitchState")
            settingsView?.changeBackgroundColor(isDark: resultNumber == 1)
        },
        SettingsModel(image: nil, labelText: "NumberOfWords".localized, isOn: false, data: [1, 2, 3, 4, 5]) { selectedNumber in
            UserDefaults.standard.set(selectedNumber, forKey: "SelectedNumberOfWords")
        },
    ]

    func getDataArray() -> [SettingsModel] {
        return arraySettings
    }

    func getSelectNumber() -> Int? {
        return UserDefaults.standard.integer(forKey: "SelectedNumberOfWords")
    }

     private func switchDark() -> Bool {
        return UserDefaults.standard.bool(forKey: "NightThemeSwitchState")
    }
}
