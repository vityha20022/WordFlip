import FirebaseAuth
import FirebaseFirestore

class AuthScreenPresenter: AuthScreenPresenterProtocol {

    var viewController: AuthViewProtocol!

    public func auth(email: String, password: String) {
        let userRequest = AuthUserRequest(email: email, password: password)

        AuthService.shared.logInUser(with: userRequest) { error in
            if let error = error {
                self.viewController.showErrorAlert(error: error.localizedDescription)
                return
            }
            self.viewController.showNextScreen()
        }
    }
}
