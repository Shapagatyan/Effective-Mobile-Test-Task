//
//  TicketPreviewViewModel.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 05.06.24.
//

import UIKit

class TicketPreviewViewModel: ViewModel {
    @Published private(set) var ticketsOffer: [TicketsOffer] = []
    @Published private(set) var filters: [Filters] = []

    @Published private(set) var returnDate = Date()
}

extension TicketPreviewViewModel {
    override func setupBinding() {
        $returnDate.sink { [weak self] date in
            self?.filters = [
                .returnFlight,
                .returnDate(date: date),
                .personsCount,
                .filters
            ]
        }.store(in: &cancellable)
    }

    func addOffers() {
        RequestService.shared.getResponse(path: .search) { [weak self] (response: TicketsOffersResponseModel?) in
            self?.ticketsOffer = response?.ticketsOffers ?? []
        }
    }
}

extension TicketPreviewViewModel {
    func changeReturnDate(to date: Date) {
        returnDate = date
    }
}

enum Filters: Hashable {
    case returnFlight
    case returnDate(date: Date)
    case personsCount
    case filters

    var title: String {
        switch self {
        case .returnFlight:
            return "обратно"
        case .returnDate(let date):
            return date.string(format: "dd.MMMM")
        case .personsCount:
            return "1,эконом"
        case .filters:
            return "фильтры"
        }
    }

    var image: UIImage? {
        switch self {
        case .returnFlight:
            return UIImage(named: "plus")
        case .returnDate:
            return nil
        case .personsCount:
            return UIImage(named: "person")
        case .filters:
            return UIImage(named: "Filter")
        }
    }
}
