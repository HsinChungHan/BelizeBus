//
//  BusStation.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/5/23.
//  Copyright © 2018年 辛忠翰. All rights reserved.
//

import UIKit
import MapKit
struct BusStation {
    var name: String
    var image: UIImage
    var location: String
    var longitude: Double //經度
    var latitude: Double //緯度
    
    init(name: String, image: UIImage, location: String, longitude: Double, latitude: Double ) {
        self.name = name
        self.image = image
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
    }
    
    static func getBusStations() -> [BusStation] {
        return [
//            17.494179,-88.193227
            BusStation.init(name: "Novelo's Bus Terminal", image: #imageLiteral(resourceName: "Novelo's Bus Terminal"), location: "West Collet Canal Street, Belize City", longitude: -88.193227, latitude: 17.494179),
//
//            17.505322, -88.197089
            BusStation.init(name: "Pallotti Junction Bus Station", image: #imageLiteral(resourceName: "Pallotti Junction"), location: "Belize City", longitude: -88.197089, latitude: 17.505322),
            //18.084247,-88.571027
           BusStation.init(name: "Orange Walk Bus Terminal", image: #imageLiteral(resourceName: "Orange Walk"), location: "Orange Walk", longitude: -88.571027, latitude: 18.084247),
           //18.403080,-88.396754
           BusStation.init(name: "Corozal Bus Station", image: #imageLiteral(resourceName: "Corozal"), location: "Corozal", longitude: -88.396754, latitude: 18.403080),
           //18.485632,-88.399283
           BusStation.init(name: "Santa Elena Border Bus Station", image: #imageLiteral(resourceName: "Santa Elena Border"), location: "Santa Elena Border", longitude: -88.399283, latitude: 18.485632)
            
        ]
    }
    
  
}


