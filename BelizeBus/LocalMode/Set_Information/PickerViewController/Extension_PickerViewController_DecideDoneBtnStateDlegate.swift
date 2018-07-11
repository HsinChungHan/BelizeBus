//
//  Extension_PickerViewController_DecideDoneBtnStateDlegate.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

extension PickerViewController: DecideDoneBtnStateDlegate{
    func disebleDoneState() {
        navigationItem.rightBarButtonItem?.isEnabled = DoneBtnStyle.Disable.set.isUserInteract
        
    }
    
    func changeDoneState(isEnable: Bool) {
        if isEnable{
            setupRightBarButtonItem(btnStyle: DoneBtnStyle.Enable)
            
        }else{
            setupRightBarButtonItem(btnStyle: DoneBtnStyle.Disable)
        }
    }
}
