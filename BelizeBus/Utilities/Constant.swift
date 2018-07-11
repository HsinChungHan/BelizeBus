//
//  Constant.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/15.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
enum JSONDirectionContent: String{
    case Southern = "Southern"
    case Northern = "Northern"
    case Western = "Western"
    
}

enum JSONBusRouteContent: String{
    case East_to_North = "East_to_North"
    case North_to_East = "North_to_East"
}

enum NorthRouteContent: String{
    case East_to_North = "East_to_North"
    case North_to_East = "North_to_East"
}

enum WestRouteContent: String{
    case East_to_West = "East_to_West"
    case West_to_East = "West_to_East"
}

enum SouthRouteContent: String{
    case East_to_South = "East_to_South"
    case South_to_East = "South_to_East"
}
enum DoneBtnStyle{
    case Disable
    case Enable
    
    var set: (size: CGFloat, color: UIColor, isUserInteract: Bool){
        switch self {
        case .Disable:
            return (16, UIColor.classicBrown, false)
        case .Enable:
            return (24, UIColor.darkOrange, true)
        }
    }
}

enum CellId: String{
    case ItineraryID = "ItineraryID"
    case BusRouteID = "BusRouteID"
    case OutboundID = "OutboundID"
}

enum TitleLabelBasicContent: String {
    case Itinerary = "Itinerary"
    case Outbound = "Outbound"
    case BusRoute = "Bus Route"
}

enum SubtilteLabelBasicContent: String{
    case Itinerary = "Tap to choose stations"
    case Outbound = "Tap to choose leaving time"
}

enum ViewConstant: CGFloat {
    case SelectionPickerViewHeight = 350
}

enum TitleOfLabel: String {
    case ItineraryFromLabel = "From"
    case ItineraryToLabel = "To"
    case OutboundDateLabel = "Date"
    case OutboundTimeLabel = "Time"
}




enum NaviTitle: String{
    case SetInformation = "Set Information"
    case BusSchedule = "Bus Schedule"
}

enum NaviItemLabelText: String{
    case DoneItem = "Done"
    case DismissItem = "Dismiss"
}

enum ButtonLabelText: String{
    case DoneButton = "Done"
}

enum CollectionViewCellId: String{
    case BusScheduleCollectionViewCellID = "BusScheduleCollectionViewCellID"
}


enum DaysOperation: String{
    case MonFriConstant = "MonFri"
    case MonSatConstant = "MonSat"
    case MonSunConstant = "MonSun"
    case MonThurConstant = "MonThur"
    case MonFri = "MonTueWedThurFri"
    case MonSat = "MonTueWedThurFriSat"
    case MonSun = "MonTueWedThurFriSatSun"
    case MonThur = "MonTueWedThur"
    case Sun = "Sun"
    case Sat = "Sat"
    
}

enum BusScheduleConstant: String{
    case companyName = "Company Name"
    case daysOperation = "Days of Operation"
    case busType = "RSP Type"
}

enum NorthenBusStations: String{
    case belizeCity = "Belize City"
    case burrellBoomJunction = "Burrell Boom Junction"
    case orangeWalk = "Orange Walk"
    case corozal = "Corozal"
    case santaElenaBorder = "Santa Elena Border"
}

enum WesternBusStations: String{
    case belizeCity = "Belize City"
    case belmopan = "Belmopan"
    case sanIgnacioTown = "San Ignacio"
    case benqueViejo = "Benque Viejo"
}


enum SouthernBusStations: String {
    case belizeCity = "Belize City"
    case belmopan = "Belmopan"
    case dangriga = "Dangriga"
    case placencia = "Placencia"
    case independence = "Independence"
    case puntaGorda = "Punta Gorda"
}
