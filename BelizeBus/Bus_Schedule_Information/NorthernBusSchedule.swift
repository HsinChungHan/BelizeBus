//
//  EastToNorth.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation

class NorthernBusSchedule: BusSchedule{
    let belizeCityArriveTime, burrellBoomJunctionArriveTime, orangeWalkArriveTime, corozalArriveTime, santaElenaBorderArriveTime: String
    
    
    override init(direction: String, dict: [String : Any]) {
        self.belizeCityArriveTime = dict[NorthenBusStations.belizeCity.rawValue] as? String ?? ""
        self.burrellBoomJunctionArriveTime = dict[NorthenBusStations.burrellBoomJunction.rawValue] as? String ?? ""
        self.orangeWalkArriveTime = dict[NorthenBusStations.orangeWalk.rawValue] as? String ?? ""
        self.corozalArriveTime = dict[NorthenBusStations.corozal.rawValue] as? String ?? ""
        self.santaElenaBorderArriveTime = dict[NorthenBusStations.santaElenaBorder.rawValue] as? String ?? ""
        super.init(direction: direction, dict: dict)
    }
    
    override func fetchValue(index: String) -> String?{
        switch index {
        case NorthenBusStations.belizeCity.rawValue:
            return belizeCityArriveTime
        case NorthenBusStations.burrellBoomJunction.rawValue:
            return burrellBoomJunctionArriveTime
        case NorthenBusStations.orangeWalk.rawValue:
            return orangeWalkArriveTime
        case NorthenBusStations.corozal.rawValue:
            return corozalArriveTime
        case NorthenBusStations.santaElenaBorder.rawValue:
            return santaElenaBorderArriveTime
        default:
            return nil
        }
    }
    
    override func fetchFinalBusStation() -> String {
        var finalStation = String()
        //此順序是East_to_North
        var busStationAndArriveTimes = [
            (NorthenBusStations.belizeCity.rawValue, belizeCityArriveTime),
            (NorthenBusStations.burrellBoomJunction.rawValue, burrellBoomJunctionArriveTime),
            (NorthenBusStations.orangeWalk.rawValue, orangeWalkArriveTime),
            (NorthenBusStations.corozal.rawValue, corozalArriveTime),
            (NorthenBusStations.santaElenaBorder.rawValue, santaElenaBorderArriveTime),
        ]
        if direction == NorthRouteContent.East_to_North.rawValue{
            //此順序是East_to_North
            for (station, time) in busStationAndArriveTimes{
                if !time.isEmpty{
                    finalStation = station
                }
            }
        }else{
            //此順序是North_to_East
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


