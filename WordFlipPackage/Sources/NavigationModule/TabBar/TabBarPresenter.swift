public protocol TabBarPresenterProtocol {
    func didTapButton(withTag tag: Int)
}

public final class TabBarPresenter: TabBarPresenterProtocol {
    weak var view: TabBarViewControllerProtocol?

    public init(view: TabBarViewControllerProtocol) {
        self.view = view
    }

    public func didTapButton(withTag tag: Int) {
        view?.updateSelected(index: tag)
    }
}
