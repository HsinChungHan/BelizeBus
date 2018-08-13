//
//  MainTabBarController.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

import UIKit
class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    
    func setupViewController(){
        
        //vieCOntroller tab
        
        let indexViewController = IndexViewController()
        let indexNaviVC = templateNaviViewController(rootViewController: indexViewController, unselectedImage: "", selectedImage: "", title: "index")
        
        //search tab
        let pickerViewController = PickerViewController()
        let pickerNaviVC = templateNaviViewController(rootViewController: pickerViewController, unselectedImage: "", selectedImage: "", title: "picker")
        
        viewControllers = [indexNaviVC,
                           pickerNaviVC,
        ]
        
        //因為icom預設在tab bar中，是中間偏上，所以我們要用程式碼的方式調整位置
        //modify tab bar item inset
        //需在把所有naviVC塞到viewControllers後再行調整
        guard let items = tabBar.items else {return}
        for item in items{
            //讓item中的image往下一點，到正中央的位置
            //其中buttom調整為-4是因為，要讓整張圖片可以往下4，比例才不會跑掉
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }
    
    fileprivate func templateNaviViewController(rootViewController: UIViewController, unselectedImage: String, selectedImage: String, title: String) -> UINavigationController{
        let naviVC = UINavigationController(rootViewController: rootViewController)
        naviVC.tabBarItem.image = UIImage(named: unselectedImage)?.withRenderingMode(.alwaysOriginal)
        naviVC.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        naviVC.tabBarItem.title = title
        return naviVC
    }
}






