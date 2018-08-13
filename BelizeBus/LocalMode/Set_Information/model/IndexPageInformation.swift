//
//  IndexInformation.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
struct IndexPageInformation  {
    var startStation, endStation, time: String
    var transportedStation: String?
    
    
    init(startStation: String, endStation: String, transportedStation: String?, time: String){
        self.startStation = startStation
        self.endStation = endStation
        self.time = time
        self.transportedStation = transportedStation
    }
}
