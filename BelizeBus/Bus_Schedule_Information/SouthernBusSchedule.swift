//
//  SouthenBusSchedule.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/25.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
class SouthernBusSchedule: BusSchedule{
    let belizeCityArriveTime, belmopanArriveTime, dangriaArriveTime, placenciaArriveTime, independenceArriveTime, puntaGordaArriveTime: String
    
    override init(direction: String, dict: [String : Any]) {
        self.belizeCityArriveTime = dict[SouthernBusStations.belizeCity.rawValue] as? String ?? ""
        self.belmopanArriveTime = dict[SouthernBusStations.belmopan.rawValue] as? String ?? ""
        self.dangriaArriveTime = dict[SouthernBusStations.dangriga.rawValue] as? String ?? ""
        self.placenciaArriveTime = dict[SouthernBusStations.placencia.rawValue] as? String ?? ""
        self.independenceArriveTime = dict[SouthernBusStations.independence.rawValue] as? String ?? ""
        self.puntaGordaArriveTime = dict[SouthernBusStations.puntaGorda.rawValue] as? String ?? ""
        super.init(direction: direction, dict: dict)
    }
    
    override func fetchValue(index: String) -> String?{
        switch index {
        case SouthernBusStations.belizeCity.rawValue:
            return belizeCityArriveTime
        case SouthernBusStations.belmopan.rawValue:
            return belmopanArriveTime
        case SouthernBusStations.dangriga.rawValue:
            return dangriaArriveTime
        case SouthernBusStations.placencia.rawValue:
            return placenciaArriveTime
        case SouthernBusStations.independence.rawValue:
            return independenceArriveTime
        case SouthernBusStations.puntaGorda.rawValue:
            return puntaGordaArriveTime
        default:
            return nil
        }
    }
    
    
    override func fetchFinalBusStation() -> String {
        var finalStation = String()
        //此順序是East_to_South
        var busStationAndArriveTimes = [
            (SouthernBusStations.belizeCity.rawValue, belizeCityArriveTime),
            (SouthernBusStations.belmopan.rawValue, belmopanArriveTime),
            (SouthernBusStations.dangriga.rawValue, dangriaArriveTime),
            (SouthernBusStations.placencia.rawValue, placenciaArriveTime),
            (SouthernBusStations.independence.rawValue, independenceArriveTime),
            (SouthernBusStations.puntaGorda.rawValue, puntaGordaArriveTime),
            ]
        if direction == SouthRouteContent.East_to_South.rawValue{
            //此順序是East_to_South
            for (station, time) in busStationAndArriveTimes{
                if !time.isEmpty{
                    finalStation = station
                }
            }
        }else{
            //此順序是South_to_East
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


