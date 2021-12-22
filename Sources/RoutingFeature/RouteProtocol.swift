import Foundation
import UIKit

// swiftlint:disable identifier_name line_length
public let PopupWillShowNotificationName = Notification.Name("PopupWillShowNotificationName")
public let PopupWillHideNotificationName = Notification.Name("PopupWillHideNotificationName")

public protocol RouteProtocol {
    var viewController: UIViewController { get }

    // Override if necessary
    func configure(navigationController: UINavigationController)
    func configureCloseButton(viewController: UIViewController)
}

extension RouteProtocol {
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
    
    public func presentNoAnimation(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
//        let transition = CATransition()
//        transition.duration = 0.1
//        transition.type = CATransitionType.fade
//        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
//        viewController.navigationController?.view.layer.add(transition, forKey: nil)
        viewController.present(self.viewController, animated: false, completion: completion)
    }

    public func presentWithNavigationFrom(_ viewController: UIViewController,
                                          animated: Bool = true,
                                          setupCloseButton: Bool = false,
                                          completion: CallBack? = nil) {
        let navCtrl = BlinqNavigationController(rootViewController: self.viewController)
        navCtrl.modalPresentationStyle = .overCurrentContext
        navCtrl.modalPresentationCapturesStatusBarAppearance = true
        configure(navigationController: navCtrl)
        if setupCloseButton {
            configureCloseButton(viewController: navCtrl.topViewController!)
        }
        viewController.navigationController?.present(navCtrl, completion: completion, duration: 0.3)
    }

    public func pushFrom(_ viewController: UIViewController, animated: Bool = true, isFade: Bool = true) {
        guard isFade else {
            viewController.navigationController?.pushViewController(self.viewController, animated: animated)
            return
        }
        pushWithFadeFrom(viewController)
    }

    public func pushWithFadeFrom(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        viewController.navigationController?.view.layer.add(transition, forKey: nil)
        pushFrom(viewController, animated: false, isFade: false)
    }

    public func replace(_ viewController: UIViewController, animated: Bool = false) {
        guard let navigationController = viewController.navigationController else { return }
        var vcs = Array(navigationController.viewControllers.dropLast())
        vcs.append(self.viewController)
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        navigationController.view.layer.add(transition, forKey: nil)
        navigationController.setViewControllers(vcs, animated: animated)
    }
    
    public func replacePush(_ viewController: UIViewController) {
        guard let navigationController = viewController.navigationController else { return }
        var vcs = Array(navigationController.viewControllers.dropLast())
        vcs.append(self.viewController)
        navigationController.setViewControllers(vcs, animated: true)
    }

    public func replaceNavigationStack(_ viewController: UIViewController,
                                       animated: Bool = false,
                                       duration: Double = 0.2) {
        if duration > 0 {
            let transition = CATransition()
            transition.duration = duration
            transition.type = CATransitionType.fade
            transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
            viewController.navigationController?.view.layer.add(transition, forKey: nil)
        }
        viewController.navigationController?.setViewControllers([self.viewController], animated: animated)
    }
}

extension RouteProtocol {
    // Do nothing. Override in subclasses
    public func configure(navigationController: UINavigationController) {}

    // Do nothing. Override in subclasses
    public func configureCloseButton(viewController: UIViewController) {}
}

extension Array where Element == UIViewController {
    public func replaceNavigationStack(_ viewController: UIViewController, animated: Bool = false) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        viewController.navigationController?.view.layer.add(transition, forKey: nil)
        viewController.navigationController?.setViewControllers(self.map{ $0 }, animated: animated)
    }
}

extension Array where Element == RouteProtocol {
    public func replaceNavigationStack(_ viewController: UIViewController, animated: Bool = false) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        transition.timingFunction = .init(name: CAMediaTimingFunctionName.default)
        viewController.navigationController?.view.layer.add(transition, forKey: nil)
        viewController.navigationController?.setViewControllers(self.map{ $0.viewController }, animated: animated)
    }
}
