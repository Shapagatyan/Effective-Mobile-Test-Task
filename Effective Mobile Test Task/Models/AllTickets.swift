//
//  TicketsOffers.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 04.06.24.
//

import Foundation

// MARK: - TicketsOffersRequestModel
class AllTicketsResponseModel: Codable {
    let tickets: [Ticket]
}

// MARK: - Ticket
class Ticket: NSObject, Codable {
    let id: Int
    let badge: String?
    let price: Price
    let providerName: String
    let company: String
    let departure: Arrival
    let arrival: Arrival
    let hasTransfer: Bool
    let hasVisaTransfer: Bool
    let luggage: Luggage
    let handLuggage: HandLuggage
    let isReturnable: Bool
    let isExchangable: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case badge
        case price
        case providerName = "provider_name"
        case company
        case departure
        case arrival
        case hasTransfer = "has_transfer"
        case hasVisaTransfer = "has_visa_transfer"
        case luggage
        case handLuggage = "hand_luggage"
        case isReturnable = "is_returnable"
        case isExchangable = "is_exchangable"
    }
}

// MARK: - Arrival
class Arrival: Codable {
    let town: Town
    let date: String
    let airport: Airport
}

enum Airport: String, Codable {
    case aer = "AER"
    case vko = "VKO"
}

enum Town: String, Codable {
    case москва = "Москва"
    case сочи = "Сочи"
}

// MARK: - HandLuggage
class HandLuggage: Codable {
    let hasHandLuggage: Bool
    let size: String?

    enum CodingKeys: String, CodingKey {
        case hasHandLuggage = "has_hand_luggage"
        case size
    }
}

// MARK: - Luggage
class Luggage: Codable {
    let hasLuggage: Bool
    let price: Price?

    enum CodingKeys: String, CodingKey {
        case hasLuggage = "has_luggage"
        case price
    }
}
