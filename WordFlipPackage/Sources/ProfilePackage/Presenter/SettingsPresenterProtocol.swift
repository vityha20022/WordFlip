protocol SettingsPresenterProtocol: AnyObject {
    func numberRowsInSection(section: Int) -> Int
    func getDataArray() -> [SettingsModel]
}
