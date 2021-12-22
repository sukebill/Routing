//
//  CustomerRouteProtocol.swift
//  RoutingFeature
//
//  Created by Bill Alexantrov on 8/11/21.
//  Copyright © 2021 blinq Ltd. All rights reserved.
//

import Foundation
import UIKit

public protocol CustomerRouteProtocol {
    var viewController: UIViewController { get }

    // Override if necessary
    func configure(navigationController: UINavigationController)
    func configureCloseButton(viewController: UIViewController)
}

extension CustomerRouteProtocol {
    // Do nothing. Override in subclasses
    public func configure(navigationController: UINavigationController) {}

    // Do nothing. Override in subclasses
    public func configureCloseButton(viewController: UIViewController) {}
}

extension CustomerRouteProtocol {
    public typealias CallBack = () -> Void
    
    public func presentFrom(_ viewController: UIViewController, animated: Bool = true, completion: CallBack? = nil) {
        if viewController.navigationController == nil {
            viewController.present(self.viewController, animated: animated, completion: completion)
        } else {
            viewController.navigationController?.present(self.viewController,
                                                         animated: animated,
                                                         completion: completion)
        }
    }
    
    public func presentWithNavigationFrom(_ viewController: UIViewController,
                                          animated: Bool = true,
                                          setupCloseButton: Bool = false,
                                          completion: CallBack? = nil) {
        let navCtrl =  CustomerNavigationController(rootViewController: self.viewController)
        navCtrl.modalPresentationStyle = .overCurrentContext
        navCtrl.modalPresentationCapturesStatusBarAppearance = true
        configure(navigationController: navCtrl)
        if setupCloseButton {
            configureCloseButton(viewController: navCtrl.topViewController!)
        }
        viewController.navigationController?.present(navCtrl, completion: completion, duration: 0.3)
    }
    
    public func pushFrom(_ viewController: UIViewController) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(nil)
        viewController.navigationController?.pushViewController(self.viewController, animated: true)
        CATransaction.commit()
    }
    
    public func pushWithFadeFrom(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        viewController.navigationController?.view.layer.add(transition, forKey: nil)
        viewController.navigationController?.pushViewController(self.viewController, animated: false)
    }
    
    public func replace(_ viewController: UIViewController) {
        guard let navigationController = viewController.navigationController else { return }
        var vcs = Array(navigationController.viewControllers.dropLast())
        vcs.append(self.viewController)
        CATransaction.begin()
        CATransaction.setCompletionBlock(nil)
        navigationController.setViewControllers(vcs, animated: true)
        CATransaction.commit()
    }
    
    public func replaceFade(_ viewController: UIViewController) {
        guard let navigationController = viewController.navigationController else { return }
        var vcs = Array(navigationController.viewControllers.dropLast())
        vcs.append(self.viewController)
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        navigationController.view.layer.add(transition, forKey: nil)
        navigationController.setViewControllers(vcs, animated: false)
    }
    
    public func replaceNavigationStack(_ viewController: UIViewController,
                                       animated: Bool = true) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(nil)
        viewController.navigationController?.setViewControllers([self.viewController], animated: animated)
        CATransaction.commit()

    }
}

extension Array where Element == UIViewController {
    public func replaceNavigationStackSwipe(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationController?.setViewControllers(self.map{ $0 }, animated: animated)
    }
}

extension Array where Element == CustomerRouteProtocol {
    public func replaceNavigationStackSwipe(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationController?.setViewControllers(self.map{ $0.viewController }, animated: animated)
    }
    
    public func replaceNavigationStack(_ viewController: UIViewController, animated: Bool = false) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        viewController.navigationController?.view.layer.add(transition, forKey: nil)
        viewController.navigationController?.setViewControllers(self.map{ $0.viewController }, animated: animated)
    }
}
