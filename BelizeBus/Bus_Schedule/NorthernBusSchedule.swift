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
    let stations = [
        NorthenBusStations.belizeCity.rawValue,
        NorthenBusStations.burrellBoomJunction.rawValue,
        NorthenBusStations.orangeWalk.rawValue,
        NorthenBusStations.corozal.rawValue,
        NorthenBusStations.santaElenaBorder.rawValue,
        ]
    
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
            return self.belizeCityArriveTime
        case NorthenBusStations.burrellBoomJunction.rawValue:
            return self.burrellBoomJunctionArriveTime
        case NorthenBusStations.orangeWalk.rawValue:
            return self.orangeWalkArriveTime
        case NorthenBusStations.corozal.rawValue:
            return self.corozalArriveTime
        case NorthenBusStations.santaElenaBorder.rawValue:
            return self.santaElenaBorderArriveTime
        default:
            return nil
        }
    }
    
    static func setNorthStations() -> [String]{
        return [
            NorthenBusStations.belizeCity.rawValue,
            NorthenBusStations.burrellBoomJunction.rawValue,
            NorthenBusStations.orangeWalk.rawValue,
            NorthenBusStations.corozal.rawValue,
            NorthenBusStations.santaElenaBorder.rawValue,
            NorthenBusStations.belizeCity.rawValue,
            NorthenBusStations.burrellBoomJunction.rawValue,
            NorthenBusStations.orangeWalk.rawValue,
            NorthenBusStations.corozal.rawValue,
            NorthenBusStations.santaElenaBorder.rawValue,
        ]
    }
}


