//
//  CustomerNavigationController.swift
//  RoutingFeature
//
//  Created by Bill Alexantrov on 8/11/21.
//  Copyright © 2021 blinq Ltd. All rights reserved.
//

import UIKit

public class CustomerNavigationController: UINavigationController {
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        childForStatusBarStyle?.preferredStatusBarStyle ?? topViewController?.preferredStatusBarStyle ?? .default
    }
    
    @discardableResult
    public func popViewControllerFade() -> UIViewController? {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        view.layer.add(transition, forKey: nil)
        return popViewController(animated: false)
    }
}
