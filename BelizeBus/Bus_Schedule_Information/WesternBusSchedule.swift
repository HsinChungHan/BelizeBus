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
    
    
    override func fetchFinalBusStation() -> String {
        var finalStation = String()
        //此順序是East_to_West
        var busStationAndArriveTimes = [
            (WesternBusStations.belizeCity.rawValue, belizeCityArriveTime),
            (WesternBusStations.belmopan.rawValue, belmopanArriveTime),
            (WesternBusStations.sanIgnacioTown.rawValue, sanIgnacioTownArriveTime),
            (WesternBusStations.benqueViejo.rawValue, benqueViejoArriveTime),
            ]
        if direction == WestRouteContent.East_to_West.rawValue{
            //此順序是East_to_West
            for (station, time) in busStationAndArriveTimes{
                if !time.isEmpty{
                    finalStation = station
                }
            }
        }else{
            //此順序是West_to_East
            busStationAndArriveTimes.reverse()
            for (station, time) in busStationAndArriveTimes{
                if !time.isEmpty{
                    finalStation = station
                }
            }
        }
        return finalStation
    }
}

