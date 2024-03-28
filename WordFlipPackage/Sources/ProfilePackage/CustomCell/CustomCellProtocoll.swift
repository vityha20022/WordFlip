import UIKit

protocol CustomCellProtocoll: UITableViewCell {
    func configure(image: UIImage?, text: String?, isOn: Bool, selectedNumber: Int?, closureForAction: ((Int) -> Void)?)
}
