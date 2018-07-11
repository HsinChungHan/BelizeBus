//
//  CustomPinAnnotation.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/5/24.
//  Copyright © 2018年 辛忠翰. All rights reserved.
//

import UIKit
import MapKit

class CustomPinAnnotation: NSObject, MKAnnotation {
    var busStation: BusStation
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(busStation.latitude, busStation.longitude)
    }
    
    init(busStation: BusStation) {
        self.busStation = busStation
        super.init()
    }
    
    var title: String?{
        return busStation.name
    }
    
    var subtitle: String?{
        return busStation.location
    }
    

    
}
