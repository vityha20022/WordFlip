import UIKit

final class ProfilePresenter: ProfilePresenterProtocol {

    weak var profileView: ProfileViewProtocol!
    var arrayProfile = [
        ProfileModel(image: UIImage(systemName: "person.crop.circle"), labelText: "username", isOn: false, closureForAction: nil),
        ProfileModel(image: UIImage(systemName: "gear"), labelText: "Settings", isOn: false, closureForAction: nil),
        ProfileModel(image: UIImage(systemName: "info.circle"), labelText: "About the program", isOn: false, closureForAction: nil),
    ]

    func getDataArray() -> [ProfileModel] {
        return arrayProfile
    }

    func didTapSettings(cellIndex: Int) {
        if cellIndex == 1 {
            profileView.showSettingsScreen()
        } else if cellIndex == 2 {
            profileView.showAppInfoAlert()
        }
    }
}
