import UIKit

final class SettingsPresenter: SettingsPresenterProtocol {
    
    weak var settingsView: SettingsViewProtocol!
    var arraySettings = [
        SettingsModel(image: nil, labelText: "Night theme", isOn: false, data: []) { resultNumber in
            //TODO: нужно отправить запрос в firebase и положить в userdefaults 
            if resultNumber == 1 {
                print("switch is On")
            } else {
                print("switch is Off")
            }
        },
        SettingsModel(image: nil, labelText: "Number of words", isOn: false, data: [1, 2, 3, 4, 5]) { selectedNumber in
            //TODO: нужно отправить запрос в firebase и положить в userdefaults
            print("menu select: \(selectedNumber)")
        }
    ]
    
    func getDataArray() -> [SettingsModel] {
        return arraySettings
    }
}
