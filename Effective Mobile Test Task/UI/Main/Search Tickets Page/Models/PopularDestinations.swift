//
//  PopularDestinations.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 02.06.24.
//

import UIKit

enum PopularDestinations: CaseIterable {
    case Istanbul
    case Sochi
    case Phuket

    var image: UIImage? {
        switch self {
        case .Istanbul:
            return UIImage(named: "Istanbul")
        case .Sochi:
            return UIImage(named: "Sochi")
        case .Phuket:
            return UIImage(named: "Phuket")
        }
    }

    var title: String? {
        switch self {
        case .Istanbul:
            return "Стамбул"
        case .Sochi:
            return "Coчи"
        case .Phuket:
            return "Пхукет"
        }
    }
}
