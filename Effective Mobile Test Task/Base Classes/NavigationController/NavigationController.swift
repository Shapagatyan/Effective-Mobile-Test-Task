//
//  NavigationController.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import UIKit

class NavigationController: UINavigationController {
    
    // MARK: - Properties
    var navigationTintColor: UIColor {
        return .appTextColor
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

// MARK: - Setup UI
private extension NavigationController {
    func setupUI() {
        let textColor: UIColor = .appTextColor
        let appearance = navigationBar.standardAppearance
        appearance.shadowColor = .clear
        appearance.backgroundColor = .appBackgroundColor
        appearance.titleTextAttributes = [
            .foregroundColor: textColor]

        navigationBar.tintColor = textColor
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}

// MARK: - Startup
private extension NavigationController {
    func startup() {
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
    }
}

// MARK: - Actions
extension NavigationController {
    private func updateNavigationBar(_ viewController: UIViewController) {
        guard let controller = viewController as? ViewController else { return }

//        if self.viewControllers.first == controller {
//            controller.navigationItem.setLeftBarButtonItems([
//                UIBarButtonItem(customView: UIImageView(image: UIImage(named: "small logo")))
//            ], animated: false)
//        }

        let clearView = UIView(frame: .zero)
        clearView.backgroundColor = .clear
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(customView: clearView)
        controller.navigationItem.titleView?.tintColor = controller.navigationTintColor
        if isNavigationBarHidden != controller.navigationBarHidden {
            setNavigationBarHidden(controller.navigationBarHidden, animated: true)
        }
    }
}

// MARK: - Navigation delegate
extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.updateNavigationBar(viewController)
            }) { _ in
                if let controller = self.viewControllers.last as? ViewController {
                    self.updateNavigationBar(controller)
                }
            }
        } else {
            updateNavigationBar(viewController)
        }
        setNeedsStatusBarAppearanceUpdate()
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        updateNavigationBar(viewController)
    }
}

// MARK: - Gesture recognizer delegate
extension NavigationController: UIGestureRecognizerDelegate {}
