//
//  ChooseTicketsViewModel.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import Foundation

class ChooseTicketsViewModel: ViewModel {
    @Published private(set) var offers: [Offer] = []
}

extension ChooseTicketsViewModel {
    func addOffers() {
        RequestService.shared.getResponse(path: .home) { [weak self] (response: OffersResponseModel?) in
            self?.offers = response?.offers ?? []
        }
    }
}
