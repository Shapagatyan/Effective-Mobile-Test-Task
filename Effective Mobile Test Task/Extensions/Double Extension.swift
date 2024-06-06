//
//  Double Extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 01.06.24.
//

import Foundation

extension Double {
    var string: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.roundingMode = .floor
        numberFormatter.groupingSeparator = " "
        numberFormatter.decimalSeparator = "."
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    var timeString: String {
        let hours = Int(self / 3600)
        let min = Int(self / 60) % 60
        if hours > 0 {
            return String(format: "%i:%02i", arguments: [hours, min])
        }
        return String(format: "%02i", arguments: [min])
    }
    

}
