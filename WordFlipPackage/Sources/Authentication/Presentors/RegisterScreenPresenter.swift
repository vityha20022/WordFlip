import FirebaseAuth
import FirebaseFirestore

class RegisterScreenPresenter: RegisterScreenPresenterProtocol {

    weak var viewController: RegisterViewProtocol!

    // MARK: Register User

    func register(username: String, email: String, password: String) {
        let userRequest = RegisterUserRequest(username: username, eMail: email, password: password)

        AuthService.shared.registerUser(with: userRequest) { _, error in
            if let error = error {
                self.viewController.showErrorAlert(error: error.localizedDescription)
                return
            }
            self.viewController.showNextScreen()
        }
    }
}
