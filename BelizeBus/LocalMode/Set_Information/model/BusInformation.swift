//
//  BusInformation.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/19.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit



struct BusInformation {
    var busRoute: String
    var startStation, endStation, day: String
    var hour: Int, minute: Int
    
    
    init(busRoute: String, startStation: String, endStation: String, day: String, hour: Int, minute: Int){
        self.busRoute = busRoute
        self.startStation = startStation
        self.endStation = endStation
        self.day = day
        self.hour = hour
        self.minute = minute
    }
    
}
