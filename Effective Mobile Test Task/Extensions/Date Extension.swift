//
//  Date Extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 05.06.24.
//

import UIKit

extension Date {
    func string(format: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "dd.MMMM.yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}
