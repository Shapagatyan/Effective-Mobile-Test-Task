//
//  TabBarController.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var controllers: [TabBarControllerType: UIViewController] = {
        var controllers: [TabBarControllerType: UIViewController] = [:]
        for type in TabBarControllerType.allCases {
            let controller = NavigationController(rootViewController: type.controller)
            controller.tabBarItem = UITabBarItem(title: type.title, image: type.image, selectedImage: type.image)
            controllers[type] = controller
        }
        return controllers
    }() {
        didSet {
            updateControllers()
        }
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateControllers()
        setupView()
    }

    // MARK: - Actions
    private func updateControllers() {
        let viewControllers = controllers.sorted(by: { $0.key.rawValue < $1.key.rawValue }).map { $0.value }
        setViewControllers(viewControllers, animated: true)
    }
    
    private func setupView() {
//        self.tabBar.tintColor = .appBackgroundColor
        self.tabBar.backgroundColor = .appBackgroundColor
    }
}

// MARK: - Helpers
enum TabBarControllerType: Int, CaseIterable {
    case aviaTickets
    case hotels
    case shortcut
    case subscriptions
    case profile

    var title: String {
        switch self {
        case .hotels:
            return "Отели"
        case .profile:
            return "Профиль"
        case .shortcut:
            return "Короче"
        case .aviaTickets:
            return "Авиабилеты"
        case .subscriptions:
            return "Подписки"
        }
    }

    var controller: UIViewController {
        switch self {
        case .hotels:
            return ViewController()
        case .profile:
            return ViewController()
        case .shortcut:
            return ViewController()
        case .aviaTickets:
            return ChooseTicketsController()
        case .subscriptions:
            return ViewController()
        }
    }

    var image: UIImage? {
        switch self {
        case .hotels:
            return UIImage(named: "HotelsIcon")
        case .profile:
            return UIImage(named: "ProfileIcon")
        case .shortcut:
            return UIImage(named: "HotelsIcon")
        case .aviaTickets:
            return UIImage(named: "AviaTicketsIcon")
        case .subscriptions:
            return UIImage(named: "SubscriptionsIcon")
        }
    }
}
