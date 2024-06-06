//
//  UIColor Extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    // MARK: HEX
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int & 0xFF, int >> 24 & 0xFF, int >> 16 & 0xFF, int >> 8 & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(displayP3Red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static var appTextColor: UIColor {
        return UIColor(hex: "#D9D9D9")
    }
    
    static var appBackgroundColor: UIColor {
        return UIColor(hex: "#0C0C0C")
    }
    
    static var appGreenColor: UIColor {
        return UIColor(hex: "#3A633B")
    }
    
    static var appBlueColor: UIColor {
        return UIColor(hex: "#4C95FE")
    }
    
    static var appDarkBlueColor: UIColor {
        return UIColor(hex: "#FF5E5E")
    }
    
    static var appRedColor: UIColor {
        return UIColor(hex: "#FF5E5E")
    }
}
