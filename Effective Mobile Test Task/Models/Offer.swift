//
//  Offer.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 04.06.24.
//

import Foundation

class OffersResponseModel: Codable {
    let offers: [Offer]
}

// MARK: - Offer
class Offer: NSObject, Codable {
    let id: Int
    let title: String
    let town: String
    let price: Price

    var imageName: String {
        return "imageForId\(id)"
    }
}

// MARK: - Price
class Price: NSObject, Codable {
    let value: Int
}
