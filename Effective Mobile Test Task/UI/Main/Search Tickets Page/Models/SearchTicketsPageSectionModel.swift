//
//  SearchTicketsPageSectionModel.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 02.06.24.
//

import Foundation

// MARK: - Helpers
enum SearchTicketsPageSectionModel: Equatable, Hashable {
    case helpers(item: [SearchTicketsPageModel])
    case popularDestinations(items: [SearchTicketsPageModel])

    var items: [SearchTicketsPageModel] {
        switch self {
        case .helpers(let item):
            return item
        case .popularDestinations(let items):
            return items
        }
    }
}

enum SearchTicketsPageModel: Equatable, Hashable {
    case helpers(item: Helpers)
    case popularDestinations(item: PopularDestinations)
}
