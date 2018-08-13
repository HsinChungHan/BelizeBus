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
    
    
    static func allStations() -> [String]{
        return[
            WesternBusStations.benqueViejo.rawValue,
            NorthenBusStations.belizeCity.rawValue,
            WesternBusStations.belmopan.rawValue,
             NorthenBusStations.burrellBoomJunction.rawValue,
            NorthenBusStations.corozal.rawValue,
            SouthernBusStations.dangriga.rawValue,
            SouthernBusStations.independence.rawValue,
             NorthenBusStations.orangeWalk.rawValue,
            SouthernBusStations.placencia.rawValue,
            SouthernBusStations.puntaGorda.rawValue,
            WesternBusStations.sanIgnacioTown.rawValue,
            NorthenBusStations.santaElenaBorder.rawValue,
        ]
    }
    
    static func checkBusCompanyArray(companyName: String) -> Bool{
        let imgArray = [
            BusCompanyImageName.Bus_bboc.rawValue,
            BusCompanyImageName.Bus_griga.rawValue,
            BusCompanyImageName.Bus_guerra.rawValue,
            BusCompanyImageName.Bus_james.rawValue,
            BusCompanyImageName.Bus_morales.rawValue,
            BusCompanyImageName.Bus_ritchie.rawValue,
            BusCompanyImageName.Bus_shaw.rawValue,
            BusCompanyImageName.Bus_silva.rawValue,
            BusCompanyImageName.Bus_tillett.rawValue,
            BusCompanyImageName.Bus_valencia.rawValue,
            BusCompanyImageName.Bus_westline.rawValue,
            ]
        if imgArray.contains(companyName){
            return true
        }
        return false
    }
}
