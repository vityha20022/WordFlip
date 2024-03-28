import UIKit

public enum BaseColorScheme: CaseIterable {
    case accent
    case baseTint
    case cardText
    case buttonText
    case red
    case backgroundColor
    case shadowColor
    case black
    case frontSideCardColor
    case downSideCardColor
    case textColor
    case profileButtonColor

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
            case .backgroundColor:
                return UIColor(named: "BackgroundColor")!
            case .shadowColor:
                return UIColor(named: "ShadowColor")!
            case .black:
                return UIColor(named: "TextColor")!
            case .frontSideCardColor:
                return UIColor(named: "FrontSideCardColor")!
            case .downSideCardColor:
                return UIColor(named: "DownSideCardColor")!
            case .textColor:
                return UIColor(named: "TextColor")!
            case .profileButtonColor:
                return UIColor(named: "ProfileButtonColor")!
        }
    }
}
