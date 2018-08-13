//
//  LocationBusSchedule.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
class LocationBusSchedule: BusSchedule{
    let belizeCityArriveTime: String?
    
    
    override init(direction: String, dict: [String : Any]) {
        self.belizeCityArriveTime = nil
        super.init(direction: direction, dict: dict)
    }
    
    
    
    
}

