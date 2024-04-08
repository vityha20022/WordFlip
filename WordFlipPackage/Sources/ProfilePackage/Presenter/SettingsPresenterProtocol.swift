protocol SettingsPresenterProtocol: AnyObject {
    func getDataArray() -> [SettingsModel]
    func getSelectNumber() -> Int?
}
