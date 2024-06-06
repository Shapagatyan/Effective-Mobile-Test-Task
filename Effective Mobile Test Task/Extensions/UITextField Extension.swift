//
//  UITextField Extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 06.06.24.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap(\.text)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
