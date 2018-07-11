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
    let stations = [
        SouthernBusStations.belizeCity.rawValue,
        SouthernBusStations.belmopan.rawValue,
        SouthernBusStations.dangriga.rawValue,
        SouthernBusStations.placencia.rawValue,
        SouthernBusStations.independence.rawValue,
        SouthernBusStations.puntaGorda.rawValue,
        ]
    
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
            return self.belizeCityArriveTime
        case SouthernBusStations.belmopan.rawValue:
            return self.belmopanArriveTime
        case SouthernBusStations.dangriga.rawValue:
            return self.dangriaArriveTime
        case SouthernBusStations.placencia.rawValue:
            return self.placenciaArriveTime
        case SouthernBusStations.independence.rawValue:
            return self.independenceArriveTime
        case SouthernBusStations.puntaGorda.rawValue:
            return self.puntaGordaArriveTime
        default:
            return nil
        }
    }
    
    static func setSouthStations() -> [String]{
        return [
            SouthernBusStations.belizeCity.rawValue,
            SouthernBusStations.belmopan.rawValue,
            SouthernBusStations.dangriga.rawValue,
            SouthernBusStations.placencia.rawValue,
            SouthernBusStations.independence.rawValue,
            SouthernBusStations.puntaGorda.rawValue,
            SouthernBusStations.belizeCity.rawValue,
            SouthernBusStations.belmopan.rawValue,
            SouthernBusStations.dangriga.rawValue,
            SouthernBusStations.placencia.rawValue,
            SouthernBusStations.independence.rawValue,
            SouthernBusStations.puntaGorda.rawValue,
        ]
    }
}


