//
//  ViewController.swift
//  Effective Mobile Test Task
//
//  Created by Анна Шапагатян on 31.05.24.
//

import Combine
import UIKit

class ViewController: UIViewController {
    // MARK: - Gestures
    private lazy var keyboardTapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction(_:)))
        tap.delegate = self
        tap.isEnabled = false
        view.addGestureRecognizer(tap)
        return tap
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private(set) var isAppeared: Bool = false

    public var autorotatePage: Bool {
        return true
    }

    // MARK: - Properties
    var cancellable: Set<AnyCancellable> = []
    public var keyboardCancellable = Set<AnyCancellable>()

    private var keyboardBottomInset: CGFloat = 0 {
        didSet {
            guard keyboardBottomInset != oldValue else { return }
            if oldValue == 0 {
                additionalSafeAreaInsets.bottom += keyboardBottomInset
            } else if oldValue != 0, keyboardBottomInset != 0 {
                additionalSafeAreaInsets.bottom = additionalSafeAreaInsets.bottom - oldValue + keyboardBottomInset
            } else {
                additionalSafeAreaInsets.bottom = max(0, additionalSafeAreaInsets.bottom - oldValue)
            }
            keyboardTapGesture.isEnabled = keyboardBottomInset > 0
            view.layoutIfNeeded()
        }
    }

    var navigationTintColor: UIColor {
        return .appTextColor
    }

    var navigationBarHidden: Bool {
        return true
    }

    public var onWillAppearAction: (() -> Void)?
    public var onDidAppearAction: (() -> Void)?

    // MARK: - Init
    required init() {
        super.init(nibName: Self.name, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Life cycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultStartup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onWillAppearAction?()
        onWillAppearAction = nil
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onDidAppearAction?()
        onDidAppearAction = nil
        observeToKeyboardChanges()
        isAppeared = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideKeyboardAction(nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
        isAppeared = false
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard isViewLoaded else { return }
        coordinator.animate(alongsideTransition: { _ in
            self.deviceOrientationChanged()
        })
    }
}

// MARK: - Startup
extension ViewController {
    private func defaultStartup() {
        view.backgroundColor = .appBackgroundColor
        setupUI()
        view.layoutIfNeeded()
        setupBindings()
        detectDevice()
        startup()
        enableLocalizations()
    }

    @objc func setupUI() {
        // Need to be overriden in child classes
    }

    @objc func setupBindings() {
        // Need to be overriden in child classes
    }

    @objc func startup() {
        // Need to be overriden in child classes
    }

    @objc func enableLocalizations() {
        // Need to be overriden in child classes
    }

    @objc func detectDevice() {
        // Need to be overriden in child classes
    }
}

// MARK: - UIGesture recognizer delegate
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view is UITextView) || (touch.view is UITextField) {
            return false
        }
        return true
    }
}

// MARK: - Actions
extension ViewController {
    private func observeToKeyboardChanges() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification, object: nil).sink { [weak self] sender in
            guard
                let self,
                let keybordBounts = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }
            UIView.animate(withDuration: 0.2) {
                self.keyboardBottomInset = keybordBounts.height - (SceneDelegate.shared?.window?.safeAreaInsets.bottom ?? 0)
            }
        }.store(in: &keyboardCancellable)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification, object: nil).sink { [weak self] _ in
            UIView.animate(withDuration: 0.2) {
                self?.keyboardBottomInset = 0
            }
        }.store(in: &keyboardCancellable)
    }

    private func removeKeyboardObservers() {
        keyboardCancellable.cancelAll()
    }

    @objc func networkStateChanged() {
        // Need to be overriden in child classes
    }

    @objc func deviceOrientationChanged() {
        // Need to be overriden in child classes
    }

    @objc final func hideKeyboardAction(_ sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
