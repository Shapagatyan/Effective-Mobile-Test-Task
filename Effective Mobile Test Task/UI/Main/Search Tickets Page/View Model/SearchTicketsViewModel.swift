//
//  SearchTicketsViewModel.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 02.06.24.
//

import Foundation

class SearchTicketsViewModel: ViewModel {
    // MARK: - Properties
    @Published private var helpers: [Helpers] = Helpers.allCases
    @Published private var popularDestination: [PopularDestinations] = PopularDestinations.allCases
    @Published private(set) var models: [SearchTicketsPageSectionModel] = []
}

extension SearchTicketsViewModel {
    func configureData() {
        let helpers = helpers.map { SearchTicketsPageModel.helpers(item: $0) }
        let popularDestination = popularDestination.map { SearchTicketsPageModel.popularDestinations(item: $0) }

        models = [
            .helpers(item: helpers),
            .popularDestinations(items: popularDestination)
        ]
    }

    override func startUp() {
        super.startUp()
        configureData()
    }
}
