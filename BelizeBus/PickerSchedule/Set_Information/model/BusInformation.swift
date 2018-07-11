//
//  BusInformation.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/19.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
enum BusStationConstant: String {
    case busRoute = "busRoute"
    case startStation = "startStation"
    case endStation = "endStation"
    case day = "day"
    case hour = "hour"
}


struct BusInformation {
    var busRoute, startStation, endStation, day: String
    var hour: Int
    
    init(busRoute: String, startStation: String, endStation: String, day: String, hour: Int){
        self.busRoute = busRoute
        self.startStation = startStation
        self.endStation = endStation
        self.day = day
        self.hour = hour
    }
}
