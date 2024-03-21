
import UIKit

public enum BaseColorScheme: CaseIterable {
    case accent, buttonText, black
    func resolve() -> UIColor {
        switch self {
            case .accent:
                return UIColor(named: "AccentColor")!
            case .buttonText:
                return UIColor(named: "ButtonTextColor")!
            case .black:
                return UIColor(named: "TextColor")!
        }
    }
}
