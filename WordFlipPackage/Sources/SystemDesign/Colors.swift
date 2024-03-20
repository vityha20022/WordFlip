//
//  File.swift
//  
//
//  Created by Виктор Борисовский on 20.03.2024.
//

import UIKit

//public enum AssetsColor {
//   case accent
//}
//
//extension UIColor {
//    public static func appColor(_ name: AssetsColor) -> UIColor? {
//        switch name {
//        case .accent:
//            return UIColor(named: "AccentColor")
//        }
//    }
//}

public enum MyColors: CaseIterable {
    case accent, buttonText
//    public static let accent = UIColor(named: "AccentColor")
    func setup() -> UIColor {
        switch self {
            case .accent:
                return UIColor(named: "AccentColor") ?? UIColor.clear
            case .buttonText:
                return UIColor(named: "ButtonTextColor") ?? UIColor.clear
        }
    }
}
