//
//  Badge.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 04.06.24.
//

import UIKit

// MARK: - TicketsOffersRequestModel
struct TicketsOffersResponseModel: Codable {
    let ticketsOffers: [TicketsOffer]

    enum CodingKeys: String, CodingKey {
        case ticketsOffers = "tickets_offers"
    }
}

// MARK: - TicketsOffer
struct TicketsOffer: Codable {
    let id: Int
    let title: String
    let timeRange: [String]
    let price: Price

    var color: UIColor? {
        return UIColor(named: "appTicketOfferColor\(id)")
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case timeRange = "time_range"
        case price
    }
}
