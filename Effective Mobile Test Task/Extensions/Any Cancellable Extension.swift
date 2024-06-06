//
//  Any Cancellable Extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import Combine

extension Set where Element: AnyCancellable {
    mutating func cancelAll() {
        forEach { $0.cancel() }
        removeAll()
    }
}
