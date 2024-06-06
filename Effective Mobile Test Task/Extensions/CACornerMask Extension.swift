//
//  CACornerMask Extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 03.06.24.
//

import UIKit

extension CACornerMask {
    static var topLeft: CACornerMask {
        return .layerMinXMinYCorner
    }

    static var topRight: CACornerMask {
        return .layerMaxXMinYCorner
    }

    static var bottomLeft: CACornerMask {
        return .layerMinXMaxYCorner
    }

    static var bottomRight: CACornerMask {
        return .layerMaxXMaxYCorner
    }
}
