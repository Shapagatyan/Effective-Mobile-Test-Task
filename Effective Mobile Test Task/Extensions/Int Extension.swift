//
//  Int Extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 04.06.24.
//

import Foundation

extension Int {
    var string: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = " "
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
