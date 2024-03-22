
import UIKit

public enum BaseColorScheme: CaseIterable {
    case accent, buttonText, backgroundColor, shadowColor
    public func resolve() -> UIColor {
        switch self {
            case .accent:
                return UIColor(named: "AccentColor")!
            case .buttonText:
                return UIColor(named: "ButtonTextColor")!
            case .backgroundColor:
                return UIColor(named: "BackgroundColor")!
            case .shadowColor:
                return UIColor(named: "ShadowColor")!
        }
    }
}
