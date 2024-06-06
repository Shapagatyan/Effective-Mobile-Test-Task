//
//  View Model.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import Foundation

import UIKit
import Combine
//import NetworkManager

class ViewModel: NSObject {
    var cancellable: Set<AnyCancellable> = []
    public let modelQueue: DispatchQueue
//    @Published public var pageStatus: PageStatus = .none
    
//    weak var networkRequest: NetworkRequest? {
//        set {
//            networkRequests.add(newValue)
//        }
//        get {
//            return networkRequests.allObjects.first
//        }
//    }
    
//    private(set) var networkRequests = NSHashTable<NetworkRequest>.weakObjects()
    
    override init() {
        modelQueue = DispatchQueue(label: "\(Self.name)_queue", qos: .userInteractive)
        super.init()
        setupBinding()
        startUp()
    }
    
    deinit {
        cancellable.forEach { $0.cancel() }
//        networkRequests.allObjects.forEach { $0.cancel() }
    }
}

// MARK: - Public methods
extension ViewModel {
    @objc func setupBinding() {}
    @objc func startUp() {}
}
