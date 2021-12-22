//
//  AppStoryboard.swift
//  RoutingFeature
//
//  Created by Vassilis Alexandrof on 19/04/2019.
//  Copyright © 2019 blinq Ltd. All rights reserved.
//

import UIKit
// swiftlint:disable force_cast
public enum AppStoryboard: String {
    case main = "Main"
    case userAuth = "UserAuth"
    case popup = "Popup"
    case dashboard = "Dashboard"
    case hamburger = "HamburgerMenu"
    case settings = "Settings"
    case generalSettings = "GeneralSettings"
    case editMenu = "EditMenu"
    case payment = "Payment"
    case reports = "Reports"
    case pastTransactions = "PastTransactions"
    case takeAway = "TakeAway"
    case delivery = "Delivery"
    case tables = "Tables"
    case clockInOut = "ClockInOut"
    case printerError = "PrinterError"
    
    //MARK: Waiter App
    case orderMenu = "OrderMenu"
    
    // MARK: Customer
    case home = "Home"
    case menu = "Menu"
    case order = "Order"
    case signUp = "SignUp"
    case signIn = "SignIn"
    case locations = "Locations"

    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardId) as! T
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
