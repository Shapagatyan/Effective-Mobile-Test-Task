//
//  SceneDelegate.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    weak static var shared: SceneDelegate?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Self.shared = self

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        UIFont.overrideInitialize()
        changeRootController(to: TabBarController())
        

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

// MARK: - Public methods
extension SceneDelegate {
    func changeRootController(to controller: UIViewController, animation: Bool = true, animationDuration: Double = 0.25, completion: (() -> Void)? = nil) {
        let action = { [self] in
            window?.clipsToBounds = true
            window?.layer.cornerRadius = 3

            guard animation else {
                window?.rootViewController?.dismiss(animated: false, completion: nil)
                window?.rootViewController = controller
                window?.makeKeyAndVisible()
                completion?()
                return
            }

            let overlayView = UIScreen.main.snapshotView(afterScreenUpdates: false)
            controller.view.addSubview(overlayView)
            window?.rootViewController?.dismiss(animated: false, completion: nil)
            window?.rootViewController = controller
            window?.makeKeyAndVisible()

            UIView.animate(withDuration: animationDuration, delay: 0, options: .transitionCrossDissolve, animations: {
                overlayView.alpha = 0
            }, completion: { _ in
                overlayView.removeFromSuperview()
                completion?()
            })
        }

        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
    
}
