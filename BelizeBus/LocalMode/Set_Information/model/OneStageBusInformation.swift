//
//  OneStageBusInformation.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation

struct OneStageBusInformation {
    let busType: String, startStation: String, endStation: String, startTime: String, endTime: String, companyName: String, finalStation: String
    init(busType: String, startStation: String, endStation: String, startTime: String, endTime: String, companyName: String, finalStation: String) {
        self.busType = busType
        self.startStation = startStation
        self.endStation = endStation
        self.startTime = startTime
        self.endTime = endTime
        self.companyName = companyName
        self.finalStation = finalStation
    }
}
