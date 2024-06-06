//
//  Combine extension.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 04.06.24.
//

import UIKit

protocol CombineCompatible { }
extension UIControl: CombineCompatible { }
extension CombineCompatible where Self: UIControl {
    func subscribe(for events: UIControl.Event) -> UIControlPublisher<Self> {
        return UIControlPublisher(control: self, events: events)
    }
}

