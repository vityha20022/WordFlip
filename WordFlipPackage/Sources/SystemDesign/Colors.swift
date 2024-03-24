
import UIKit

public enum BaseColorScheme: CaseIterable {
    case accent
    case baseTint
    case buttonText
    case red
    public func resolve() -> UIColor {
        switch self {
            case .accent:
                return UIColor(named: "AccentColor")!
            case .baseTint:
                return UIColor(red: 0.8633887172, green: 0.9207940698, blue: 0.9881599545, alpha: 1)
            case .buttonText:
                return UIColor(named: "ButtonTextColor")!
            case .red:
                return UIColor(named: "RedColor")!
        }
    }
}


