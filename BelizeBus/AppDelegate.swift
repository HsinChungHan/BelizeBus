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
    fileprivate func setupLargeNavigationBar() {
        //統一所有navigationBar的appearance
        //一定要放在最上面
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.classicDarkGreen
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                //Beta
//                NSAttributedString.Key.foregroundColor : UIColor.white
                NSAttributedStringKey.foregroundColor : UIColor.white
            ]
        } else {
            // Fallback on earlier versions
        }
    }
    
    fileprivate func setupNormalNavigationBar() {
        //統一所有navigationBar的appearance
        //一定要放在最上面
        UINavigationBar.appearance().tintColor = UIColor.white//button的顏色
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.classicDarkGreen
        UINavigationBar.appearance().titleTextAttributes = [
            //Beta
//            NSAttributedString.Key.foregroundColor : UIColor.white
            NSAttributedStringKey.foregroundColor : UIColor.white

        ]
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        setupLargeNavigationBar()
        setupNormalNavigationBar()
        window = UIWindow()
        window?.makeKeyAndVisible()
        //-------------------
//        window?.rootViewController = MapViewController()
        //-------------------
//        let pickerViewController = PickerViewController()
//        let naviVC = CustomNavigationController(rootViewController: pickerViewController)
//        window?.rootViewController = naviVC
        //-------------------
        let indexVC = IndexViewController()
//        let resultVC = ResultViewController()
        let naviVC = UINavigationController(rootViewController: indexVC)
        window?.rootViewController = naviVC
        
//        window?.rootViewController = MainTabBarController()
        Thread.sleep(forTimeInterval: 1.5)
        return true
    }

}
