protocol ProfilePresenterProtocol: AnyObject {
    func numberRowsInSection(section: Int) -> Int
    func getDataArray() -> [ProfileModel]
    func didTapSettings(cellIndex: Int)
}

