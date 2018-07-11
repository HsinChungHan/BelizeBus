//
//  Extension_ScheduleView_ChangeBusRouteProtocol.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension ScheduleView: ChangeBusRouteProtocol{
    func changeBusRoute(currentValue: String) {
        busRoute = currentValue
    }
}

