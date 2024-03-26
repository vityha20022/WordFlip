import UIKit

struct ProfileModel {
    let image: UIImage?
    let labelText: String
    let isOn: Bool
    let closureForAction: ((Int) -> Void)?
}
