import UIKit

struct SettingsModel {
    let image: UIImage?
    let labelText: String
    let isOn: Bool
    let data: [Int]
    let closureForAction: ((Int) -> Void)?
}
