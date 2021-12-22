//
//  UIViewControllerExtension.swift
//  RoutingFeature
//
//  Created by Vassilis Alexandrof on 19/04/2019.
//  Copyright © 2019 blinq Ltd. All rights reserved.
//

import UIKit

public extension UIViewController {
    class var storyboardID: String { "\(self)" }

    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        appStoryboard.viewController(viewControllerClass: self)
    }
}
