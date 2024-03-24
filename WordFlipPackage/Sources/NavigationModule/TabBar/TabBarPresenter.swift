public protocol TabBarPresenterProtocol {
    func didTapButton(withTag tag: Int)
}

public final class TabBarPresenter: TabBarPresenterProtocol {
    public weak var view: TabBarViewControllerProtocol?
    
    public init(view: TabBarViewControllerProtocol? = nil) {
        self.view = view
    }

    public func didTapButton(withTag tag: Int) {
        guard let view = view else {fatalError("No link to view is provided")}
        view.updateSelected(index: tag)
    }
}
