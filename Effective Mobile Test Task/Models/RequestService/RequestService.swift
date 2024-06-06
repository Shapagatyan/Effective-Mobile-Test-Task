//
//  RequestService.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 04.06.24.
//

import Foundation

internal class RequestService: NSObject {
    // MARK: - Properties
    public static let shared = RequestService()
}

extension RequestService {
    func getResponse<T: Codable>(path: RequestServicePath, result: @escaping (T?) -> Void) {
        var model: T?
        defer {
            result(model)
        }

        guard
            let url = Bundle.main.url(forResource: path.path, withExtension: "json")
        else { return }

        do {
            let data = try Data(contentsOf: url)
            model = try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("response error: \(error.localizedDescription)")
        }
    }
}

enum RequestServicePath {
    case home
    case search
    case allTickets

    fileprivate var path: String {
        switch self {
        case .home:
            return "home_page"
        case .search:
            return "search_result"
        case .allTickets:
            return "all_tickets"
        }
    }
}

//
 class ADASDAS: Codable {

 }
//
// RequestService.shared.getResponse(path: .home) { [weak self] (response: ADASDAS) in
//    response
// }
