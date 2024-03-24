
import UIKit

public enum BaseColorScheme: CaseIterable {
    case accent, buttonText, backgroundColor, shadowColor, red, black
  
    public func resolve() -> UIColor {
        switch self {
            case .accent:
                return UIColor(named: "AccentColor")!
            case .buttonText:
                return UIColor(named: "ButtonTextColor")!
            case .black:
                return UIColor(named: "TextColor")!
            case .backgroundColor:
                return UIColor(named: "BackgroundColor")!
            case .shadowColor:
                return UIColor(named: "ShadowColor")!
            case .red:
                return UIColor(named: "RedColor")!
        }
    }
}
