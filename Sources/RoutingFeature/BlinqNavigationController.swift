//
//  BlinqNavigationController.swift
//  RoutingFeature
//
//  Created by Vassilis Alexandrof on 17/05/2019.
//  Copyright © 2019 blinq Ltd. All rights reserved.
//

import Foundation
import UIKit

public class BlinqNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        childForStatusBarStyle?.preferredStatusBarStyle ?? topViewController?.preferredStatusBarStyle ?? .default
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         super.traitCollectionDidChange(previousTraitCollection)
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func popViewController(animated: Bool) -> UIViewController? {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        view.layer.add(transition, forKey: nil)
        return super.popViewController(animated: false)
    }
    
    @discardableResult
    public func popDefault() -> UIViewController? {
        return super.popViewController(animated: true)
    }
    
    public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        view.layer.add(transition, forKey: nil)
        return super.popToViewController(viewController, animated: false)
    }

    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        view.layer.add(transition, forKey: nil)
        return super.popToRootViewController(animated: false)
    }

    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.layer.add(transition, forKey: kCATransition)
        super.dismiss(animated: false, completion: completion)
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    public override func present(_ viewControllerToPresent: UIViewController,
                                 animated flag: Bool,
                                 completion: (() -> Void)? = nil) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        view.window?.layer.add(transition, forKey: kCATransition)
        super.present(viewControllerToPresent, animated: false)
    }
}

extension UINavigationController {
    func dismiss(completion: (() -> Void)? = nil, duration: Double) {
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.layer.add(transition, forKey: kCATransition)
        super.dismiss(animated: false, completion: completion)
    }

    func present(_ viewControllerToPresent: UIViewController, completion: (() -> Void)? = nil, duration: Double) {
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        view.window?.layer.add(transition, forKey: kCATransition)
        super.present(viewControllerToPresent, animated: false)
    }
    
    @discardableResult
    public func popViewController(duration: CFTimeInterval) -> UIViewController? {
         let transition = CATransition()
         transition.duration = duration
         transition.type = CATransitionType.fade
         transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
         view.layer.add(transition, forKey: nil)
         return popViewController(animated: false)
    }
    
    @discardableResult
    public func popToViewController(_ viewController: UIViewController) -> [UIViewController]? {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        view.layer.add(transition, forKey: nil)
        return popToViewController(viewController, animated: false)
    }
}
