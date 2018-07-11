//
//  Extension_PickerViewController_FetchFinalBusRouteDelegate.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

extension PickerViewController: FetchFinalBusRouteDelegate{
    func fetchFinalBusRoute(busRoute: String) {
        self.busRoute = busRoute
    }
}
