import UIKit

public enum BaseColorScheme: CaseIterable {
    case accent
    case baseTint
    case cardText
    case buttonText
    case red
    public func resolve() -> UIColor {
        switch self {
        case .accent:
            return UIColor(named: "AccentColor")!
        case .baseTint:
            return UIColor(named: "BaseTintColor")!
        case .cardText:
            return UIColor(named: "CardTextColor")!
        case .buttonText:
            return UIColor(named: "ButtonTextColor")!
        case .red:
            return UIColor(named: "RedColor")!
        }
    }
}
