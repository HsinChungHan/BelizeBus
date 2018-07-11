//
//  AppDelegate.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/5/23.
//  Copyright © 2018年 辛忠翰. All rights reserved.
//

import UIKit
class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

extension UINavigationController{
    open override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    fileprivate func setupNavigationBar() {
        //統一所有navigationBar的appearance
        //一定要放在最上面
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.classicDarkGreen
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBar()
        window = UIWindow()
        window?.makeKeyAndVisible()
//        window?.rootViewController = MapViewController()
        let pickerViewController = PickerViewController()
        let naviVC = CustomNavigationController(rootViewController: pickerViewController)
//        let busScheduleViewController = BusScheduleViewController()
//        let naviVC = CustomNavigationController(rootViewController: busScheduleViewController)
        window?.rootViewController = naviVC
        return true
    }

}
