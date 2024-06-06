//
//  Helpers.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 02.06.24.
//

import UIKit

enum Helpers: CaseIterable {
    case difficultRoute
    case anywhere
    case weekend
    case hotTickets

    var image: UIImage? {
        switch self {
        case .difficultRoute:
            return UIImage(named: "difficultRoute")
        case .anywhere:
            return UIImage(named: "anywhere")
        case .weekend:
            return UIImage(named: "weekend")
        case .hotTickets:
            return UIImage(named: "hotTickets")
        }
    }

    var color: UIColor? {
        switch self {
        case .difficultRoute:
            return UIColor.appGreenColor
        case .anywhere:
            return UIColor.appBlueColor
        case .weekend:
            return UIColor.appDarkBlueColor
        case .hotTickets:
            return UIColor.appRedColor
        }
    }

    var title: String? {
        switch self {
        case .difficultRoute:
            return "Сложный маршрут"
        case .anywhere:
            return "Куда угодно"
        case .weekend:
            return "Выходные"
        case .hotTickets:
            return "Горячие билеты"
        }
    }
}
