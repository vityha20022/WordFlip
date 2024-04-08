final class EnterScreenPresenter: EnterScreenPresenterProtocol {
    
    weak var viewController: EnterViewProtocol?
    
    weak var delegate: NavigationProtocol?
    
    init(delegate: NavigationProtocol?) {
        self.delegate = delegate
    }
    
    func didTapSignInButton() {
        viewController?.showAuthScreen(navDelegate: delegate)
    }
    
    func didTapRegisterButton() {
        viewController?.showRegisterScreen(navDelegate: delegate)
    }
    
}
