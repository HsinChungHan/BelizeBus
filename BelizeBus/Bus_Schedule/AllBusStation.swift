//
//  AllBusStation.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/25.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
struct AllBusStation {
    static func setNorthStations() -> [String]{
        return [
            NorthenBusStations.belizeCity.rawValue,
            NorthenBusStations.burrellBoomJunction.rawValue,
            NorthenBusStations.orangeWalk.rawValue,
            NorthenBusStations.corozal.rawValue,
            NorthenBusStations.santaElenaBorder.rawValue,
        ]
    }
    
    static func setWestStations() -> [String]{
        return [
            WesternBusStations.belizeCity.rawValue,
            WesternBusStations.belmopan.rawValue,
            WesternBusStations.sanIgnacioTown.rawValue,
            WesternBusStations.benqueViejo.rawValue,
        ]
    }
    
    static func setSouthStations() -> [String]{
        return [
            SouthernBusStations.belizeCity.rawValue,
            SouthernBusStations.belmopan.rawValue,
            SouthernBusStations.dangriga.rawValue,
            SouthernBusStations.placencia.rawValue,
            SouthernBusStations.independence.rawValue,
            SouthernBusStations.puntaGorda.rawValue,
        ]
    }
    
}
