//
//  UIFont extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 01.06.24.
//

import UIKit

enum SystemFontType {
    case regular
    case medium
    case semibold
    case bold
    case thin
    init(fontAttribute: String) {
        switch fontAttribute {
        case "CTFontRegularUsage":
            self = .regular
        case "CTFontMediumUsage":
            self = .medium
        case "CTFontDemiUsage":
            self = .semibold
        case "CTFontBoldUsage", "CTFontEmphasizedUsage":
            self = .bold
        case "CTFontThinUsage":
            self = .thin
        default:
            self = .regular
        }
    }

    var font: UIFont {
        switch self {
        case .regular:
            return .sfProDisplayRegular
        case .medium:
            return .sfProDisplayMedium
        case .semibold:
            return .sfProDisplaySemiBold
        case .bold:
            return .sfProDisplayBold
        case .thin:
            return .sfProDisplayLightItalic
        }
    }
}

private extension UIFont {
    class var sfProDisplayRegular: UIFont {
        return UIFont(name: "SFProDisplay-Regular", size: 16)!
    }

    class var sfProDisplayMedium: UIFont {
        return UIFont(name: "SFProDisplay-Medium", size: 16)!
    }

    class var sfProDisplaySemiBold: UIFont {
        return UIFont(name: "SFProDisplay-Semibold", size: 16)!
    }

    class var sfProDisplayBold: UIFont {
        return UIFont(name: "SFProDisplay-Bold", size: 16)!
    }
    
    class var sfProDisplayLightItalic: UIFont {
        return UIFont(name: "SFProDisplay-LightItalic", size: 16)!
    }
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    static var isOverrided: Bool = false

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return SystemFontType.regular.font.withSize(size)
    }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return SystemFontType.bold.font.withSize(size)
    }


    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String
        else {
            self.init(myCoder: aDecoder)
            return
        }
        let font = SystemFontType(fontAttribute: fontAttribute).font
        self.init(name: font.fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideInitialize() {
        guard self == UIFont.self, !isOverrided else { return }

        // Avoid method swizzling run twice and revert to original initialize function
        isOverrided = true

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
           let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:)))
        {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
           let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:)))
        {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }


        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
           let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
        {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
