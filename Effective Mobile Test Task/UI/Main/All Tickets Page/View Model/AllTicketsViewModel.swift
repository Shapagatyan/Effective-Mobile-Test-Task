//
//  AllTicketsViewModel.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 03.06.24.
//

import Foundation

class AllTicketsViewModel: ViewModel {
    // MARK: - Properties
    @Published private(set) var tickets: [Ticket] = []
}

extension AllTicketsViewModel {
    func addAllTickets() {
        RequestService.shared.getResponse(path: .allTickets) { [weak self] (response: AllTicketsResponseModel?) in

            self?.tickets = response?.tickets ?? []
        }
    }
}
