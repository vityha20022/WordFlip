protocol ProfilePresenterProtocol: AnyObject {
    func getDataArray() -> [ProfileModel]
    func didTapSettings(cellIndex: Int)
    func didTapSignOutButton()
}
