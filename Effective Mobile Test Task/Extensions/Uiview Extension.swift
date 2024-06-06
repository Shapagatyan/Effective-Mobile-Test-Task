//
//  Uiview Extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 02.06.24.
//

import UIKit

extension UIView {
    func setShadow(color: UIColor = .black, opacity: Float = 1, x: CGFloat = 0, y: CGFloat = 3, blur: CGFloat = 3) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    func roundCorners(radius: CGFloat, corners: CACornerMask) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }

    var hideFromStack: Bool {
        set {
            let action = { [self] in
                guard isHidden != newValue else { return }
                isHidden = newValue
                alpha = newValue ? 0 : 1
            }
            if !Thread.isMainThread {
                DispatchQueue.main.async {
                    action()
                }
            } else {
                action()
            }
        }
        get {
            return isHidden
        }
    }

    class var xibFile: Self {
        func instanceFromNib<T: UIView>() -> T {
            for view in UINib(nibName: T.name, bundle: nil).instantiate(withOwner: nil, options: nil) {
                if let xib = view as? T {
                    return xib
                }
            }

            return T(frame: .zero)
        }
        return instanceFromNib()
    }
}
