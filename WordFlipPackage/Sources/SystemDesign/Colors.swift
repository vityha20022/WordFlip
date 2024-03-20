
import UIKit

public enum BaseColorScheme: CaseIterable {
    case accent, buttonText
    func setup() -> UIColor {
        switch self {
            case .accent:
                return UIColor(named: "AccentColor")!
            case .buttonText:
                return UIColor(named: "ButtonTextColor")!
        }
    }
}
