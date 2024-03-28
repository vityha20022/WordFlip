import FirebaseAuth
import FirebaseFirestore

final class RegisterScreenPresenter: RegisterScreenPresenterProtocol {

    weak var viewController: RegisterViewProtocol?
    
    weak var delegate: NavigationProtocol?
    
    init(delegate: NavigationProtocol?) {
        self.delegate = delegate
    }

    // MARK: Register User

    func register(username: String?, email: String?, password: String?) {
        guard let username = username, let email = email, let password = password else {
            viewController?.showErrorAlert(error: "Enter your email and password")
            return
        }

        guard username != "", email != "", password != "" else {
            viewController?.showErrorAlert(error: "Enter you email and password")
            return
        }

        let userRequest = RegisterUserRequest(username: username, email: email, password: password)

        AuthService.shared.registerUser(with: userRequest) { [weak self] _, error in
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
