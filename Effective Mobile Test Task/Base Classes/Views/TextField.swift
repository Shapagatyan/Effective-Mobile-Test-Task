//
//  TextField.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 04.06.24.
//

import UIKit

class TextField: UITextField {
    override var placeholder: String? {
        set {
            setPlaceholder(newValue)
        }
        get {
            return attributedPlaceholder?.string
        }
    }

    var placeholderColor = UIColor.appGrey6 {
        didSet {
            setPlaceholder(placeholder)
        }
    }

    func setPlaceholder(_ placeholder: String?) {
        let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: placeholderColor]
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
    }

    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let placeholder = super.placeholder else { return }
        super.placeholder = nil
        setPlaceholder(placeholder)
    }
}
