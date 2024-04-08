import FirebaseAuth
import FirebaseFirestore

final class AuthScreenPresenter: AuthScreenPresenterProtocol {

    weak var viewController: AuthViewProtocol?
    
    weak var delegate: NavigationProtocol?
    
    init(delegate: NavigationProtocol?) {
        self.delegate = delegate
    }

    func auth(email: String?, password: String?) {
        guard let email = email, let password = password else {
            viewController?.showErrorAlert(error: "Enter you email and password")
            return
        }
        guard email != "", password != "" else {
            viewController?.showErrorAlert(error: "Enter you email and password")
            return
        }

        let userRequest = AuthUserRequest(email: email, password: password)

        AuthService.shared.logInUser(with: userRequest) { [weak self] error in
            guard let strongSelf = self else {
                return
            }
            if let error = error {
                strongSelf.viewController?.showErrorAlert(error: error.localizedDescription)
                return
            }
            strongSelf.delegate?.goToMainView()
        }
    }
    
}
