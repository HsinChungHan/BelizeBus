//
//  WesternBusSchedule.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/25.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
class WesternBusSchedule: BusSchedule{
    let belizeCityArriveTime, belmopanArriveTime, sanIgnacioTownArriveTime, benqueViejoArriveTime: String
    let stations = [
        WesternBusStations.belizeCity.rawValue,
        WesternBusStations.belmopan.rawValue,
        WesternBusStations.sanIgnacioTown.rawValue,
        WesternBusStations.benqueViejo.rawValue,
        ]
    
    override init(direction: String, dict: [String : Any]) {
        self.belizeCityArriveTime = dict[WesternBusStations.belizeCity.rawValue] as? String ?? ""
        self.belmopanArriveTime = dict[WesternBusStations.belmopan.rawValue] as? String ?? ""
        self.sanIgnacioTownArriveTime = dict[WesternBusStations.sanIgnacioTown.rawValue] as? String ?? ""
        self.benqueViejoArriveTime = dict[WesternBusStations.benqueViejo.rawValue] as? String ?? ""
        
        super.init(direction: direction, dict: dict)
    }
    
    override func fetchValue(index: String) -> String?{
        switch index {
        case WesternBusStations.belizeCity.rawValue:
            return self.belizeCityArriveTime
        case WesternBusStations.belmopan.rawValue:
            return self.belmopanArriveTime
        case WesternBusStations.sanIgnacioTown.rawValue:
            return self.sanIgnacioTownArriveTime
        case WesternBusStations.benqueViejo.rawValue:
            return self.benqueViejoArriveTime
        default:
            return nil
        }
    }
    
    static func setWestStations() -> [String]{
        return [
            WesternBusStations.belizeCity.rawValue,
            WesternBusStations.belmopan.rawValue,
            WesternBusStations.sanIgnacioTown.rawValue,
            WesternBusStations.benqueViejo.rawValue,
            WesternBusStations.belizeCity.rawValue,
            WesternBusStations.belmopan.rawValue,
            WesternBusStations.sanIgnacioTown.rawValue,
            WesternBusStations.benqueViejo.rawValue,
        ]
    }
}

