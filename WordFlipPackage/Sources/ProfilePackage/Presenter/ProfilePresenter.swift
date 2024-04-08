import UIKit
import Authentication

final class ProfilePresenter: ProfilePresenterProtocol {
    
    var delegate: ProfileNavigationProtocol?
    
    init(delegate: ProfileNavigationProtocol?) {
        self.delegate = delegate
    }
    
    weak var profileView: ProfileViewProtocol!
    var arrayProfile = [
        ProfileModel(image: UIImage(systemName: "person.crop.circle"), labelText: "UsernameTextLabel".localized, isOn: false, closureForAction: nil),
        ProfileModel(image: UIImage(systemName: "gear"), labelText: "Settings".localized, isOn: false, closureForAction: nil),
        ProfileModel(image: UIImage(systemName: "info.circle"), labelText: "About the program".localized, isOn: false, closureForAction: nil),
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
    
    func didTapSignOutButton() {
        AuthService.shared.signOut { error in
            guard error != nil else {
                print(error?.localizedDescription ?? "error tap sign out button")
                return
            }
        }
        delegate?.goToEnterScreen()
    }
}
