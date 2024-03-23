import UIKit

public protocol CustomCellProtocoll: UITableViewCell {
    func configure(image: UIImage?, text: String?, isOn: Bool?)
}
