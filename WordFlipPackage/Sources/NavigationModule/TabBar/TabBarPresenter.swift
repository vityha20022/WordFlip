

public protocol TabBarPresenter {
    func didTapButton(withTag tag: Int)
}

public class TabBarPresenterImp: TabBarPresenter {
    weak var view: TabBarViewControllerImp?

    public init(view: TabBarViewControllerImp) {
        self.view = view
    }

    public func didTapButton(withTag tag: Int) {
        view?.updateSelected(index: tag)
    }
}
