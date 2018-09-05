//
//  TestViewController.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
// Beta 10, swift 4.2

import UIKit

typealias TwoStagesInfo = (String, String, String, String, String, String)
typealias TwoBusInformations = (BusInformation, BusInformation)
typealias BusRoute = String



class SearchSchedulesAlgorithm {
    var northernSchedules = [NorthernBusSchedule]()
    var westernSchedules = [WesternBusSchedule]()
    var southernSchedules = [SouthernBusSchedule]()
    var newNorthernSchedules = [NorthernBusSchedule]()
    var newWesternSchedules = [WesternBusSchedule]()
    var newSouthernSchedules = [SouthernBusSchedule]()
    var busRoute: BusRoute?
    var busInformation1: BusInformation?
    var busInformation2: BusInformation?
    var startStation: String?
    var endStation: String?
    var day: String?
    var hour: Int?
    let northernStations = AllBusStation.setNorthStations()
    let westernStations = AllBusStation.setWestStations()
    let southernStations = AllBusStation.setSouthStations()
    var twoBusInformations: TwoBusInformations?
    
}




extension SearchSchedulesAlgorithm{
    func searchSchedulsForTwoStations(startStation: String, endStation: String, day: String, hour: Int, minute: Int) -> (schedules: [TwoStagesBusInformation]?, isTwoStages: Bool?, transportedStation: String?){
        var isTwoStages = false
        var transportedStation: String?
        var twoStagesBusInformations = [TwoStagesBusInformation]()
        if let busInfomation = searchStationsInSameLine(startStation: startStation, endStation: endStation, day: day, hour: hour, minute: minute){
            print("startStation: ", startStation)
            print("endStation: ", endStation)
            
            
            guard let oneStageBusInformations = searchSchedule(busInformation: busInfomation) else{return (nil, nil, nil)}
            for information in oneStageBusInformations{
                let twoStagesBusInformation = TwoStagesBusInformation.init(firstStageBusInformation: information, secondStageBusInformation: nil)
                twoStagesBusInformations.append(twoStagesBusInformation)
            }
        }else{
            isTwoStages = true
            let twoBusInformations = searchStationsInDifferentLine(startStation: startStation, endStation: endStation, day: day, hour: hour, minute: minute)
            let busFirstStageInfo = twoBusInformations.0
            let busSecondStageInfo = twoBusInformations.1
            print("busFirstStageInfo.start: ", busFirstStageInfo.startStation)
            print("busFirstStageInfo.end: ", busFirstStageInfo.endStation)
            
            
            guard let oneStageBusInformations = searchSchedule(busInformation: busFirstStageInfo) else {
                return (nil, nil, nil)
            }
            transportedStation = busFirstStageInfo.endStation
            for information in oneStageBusInformations{
                //因為用suffix抓的話，會把index字元":"也抓進去，所以我們還要多一步remove index的動作，才可以轉型成Int
                //ex 14:05，suffix完後會變成":05"，remove index後會變成"05"，再轉成Int(5)
                //詳細可以看String extension
                guard let startTimeHourStr = information.endTime.fetchPrefix(fromChar: ":"),
                    let startTimeHour = Int(startTimeHourStr),
                    let startTimeMinuteStr = information.endTime.fetchSuffix(fromChar: ":"),
                    let startTimeMinute = Int(startTimeMinuteStr)
                else {return (nil, nil, nil)}
                
               
                
//                print("startTimeMinute: ", startTimeMinute)
                let secondBusInformation = BusInformation(busRoute: busSecondStageInfo.busRoute , startStation: busSecondStageInfo.startStation, endStation: busSecondStageInfo.endStation, day: busSecondStageInfo.day, hour: startTimeHour, minute: startTimeMinute)
                
                
                
                guard let secondsStageBusInformations = searchSchedule(busInformation: secondBusInformation) else {return (nil, nil, nil)}
                if let secondStageBusInformation = secondsStageBusInformations.first{
                    let twoStagesBusInformation = TwoStagesBusInformation.init(firstStageBusInformation: information, secondStageBusInformation: secondStageBusInformation)
                    twoStagesBusInformations.append(twoStagesBusInformation)
                }
            }
        }
        
        return (twoStagesBusInformations, isTwoStages, transportedStation)
    }
    
    fileprivate func searchSchedule(busInformation: BusInformation) -> [OneStageBusInformation]?{
        let startStation = busInformation.startStation
        let endStation = busInformation.endStation
        let day = busInformation.day
        let busRoute: BusRoute? = busInformation.busRoute
        let hour = String(busInformation.hour)
        let minute = String(busInformation.minute)
        var northernSchedules = [NorthernBusSchedule]()
        var westernSchedules = [WesternBusSchedule]()
        var southernSchedules = [SouthernBusSchedule]()
        var oneStageInformationBuses = [OneStageBusInformation]()
        print("busRoute: ", busRoute)
        parseJSON(busRoute: busRoute) { (arr) in
            guard let busRoute = busRoute else {
                return
            }
            for dict in arr{
                switch busRoute{
                case NorthRouteContent.East_to_North.rawValue:
                    let schedule = NorthernBusSchedule.init(direction: busRoute , dict: dict as! [String : Any])
                    northernSchedules.append(schedule)
                case NorthRouteContent.North_to_East.rawValue:
                    let schedule = NorthernBusSchedule.init(direction: busRoute , dict: dict as! [String : Any])
                    northernSchedules.append(schedule)
                case SouthRouteContent.East_to_South.rawValue:
                    let schedule = SouthernBusSchedule.init(direction: busRoute , dict: dict as! [String : Any])
                    southernSchedules.append(schedule)
                case SouthRouteContent.South_to_East.rawValue:
                    let schedule = SouthernBusSchedule.init(direction: busRoute , dict: dict as! [String : Any])
                    southernSchedules.append(schedule)
                case WestRouteContent.East_to_West.rawValue:
                    let schedule = WesternBusSchedule.init(direction: busRoute , dict: dict as! [String : Any])
                    westernSchedules.append(schedule)
                case WestRouteContent.West_to_East.rawValue:
                    let schedule = WesternBusSchedule.init(direction: busRoute , dict: dict as! [String : Any])
                    westernSchedules.append(schedule)
                default:
                    break
                }
            }
        }
        
        if !northernSchedules.isEmpty{
            for (index, item) in northernSchedules.enumerated(){
                if item.fetchSchedule(startStation: startStation, endStation: endStation, day: day, hour: hour, minute: minute){
                    guard let startTime = item.fetchValue(index: startStation) else {return nil}
                    guard let endTime = item.fetchValue(index: endStation) else {return nil}
                    
                    print("northernSchedules")
                    print("startStation: ",startStation)
                    print("endStation: ",endStation)
                    print("start time: ", item.fetchValue(index: startStation))
                    print("end time: ",item.fetchValue(index: endStation))
                    print("companyName: ", item.comapnyName)
                    print("bus typw: ", item.busType)

                    print("---------------------------")
                    
                    let finalStation = item.fetchFinalBusStation()
                    print("finalStation: ", finalStation)
                    newNorthernSchedules.append(item)
                    let oneStageInformationBus = OneStageBusInformation.init(busType: item.busType, startStation: startStation , endStation: endStation, startTime: startTime, endTime: endTime, companyName: item.comapnyName, finalStation: finalStation)
                    oneStageInformationBuses.append(oneStageInformationBus)
                    
                }
            }
        }else if !southernSchedules.isEmpty{
            for (index, item) in southernSchedules.enumerated(){
                
                if item.fetchSchedule(startStation: startStation, endStation: endStation, day: day, hour: hour, minute: minute){
                    guard let startTime = item.fetchValue(index: startStation) else {return nil}
                    guard let endTime = item.fetchValue(index: endStation) else {return nil}
                    print("southernSchedules")
                    print("startStation: ",startStation)
                    print("endStation: ",endStation)
                    print("start time: ", item.fetchValue(index: startStation))
                    print("end time: ",item.fetchValue(index: endStation))
                    print("companyName: ", item.comapnyName)
                    print("bus typw: ", item.busType)

                    print("---------------------------")
                    newSouthernSchedules.append(item)
                    let finalStation = item.fetchFinalBusStation()
                    let oneStageInformationBus = OneStageBusInformation.init(busType: item.busType, startStation: startStation , endStation: endStation, startTime: startTime, endTime: endTime, companyName: item.comapnyName, finalStation: finalStation)
                    oneStageInformationBuses.append(oneStageInformationBus)
                }
            }
        }else if !westernSchedules.isEmpty{
            for (index, item) in westernSchedules.enumerated(){
                if item.fetchSchedule(startStation: startStation, endStation: endStation, day: day, hour: hour, minute: minute){
                    guard let startTime = item.fetchValue(index: startStation) else {return nil}
                    guard let endTime = item.fetchValue(index: endStation) else {return nil}
                    print("westernSchedules")
                    print("startStation: ",startStation)
                    print("endStation: ",endStation)
                    print("start time: ", item.fetchValue(index: startStation))
                    print("end time: ",item.fetchValue(index: endStation))
                    print("companyName: ", item.comapnyName)
                    print("bus typw: ", item.busType)

                    print("---------------------------")
                    newWesternSchedules.append(item)
                    let finalStation = item.fetchFinalBusStation()
                    let oneStageInformationBus = OneStageBusInformation.init(busType: item.busType, startStation: startStation , endStation: endStation, startTime: startTime, endTime: endTime, companyName: item.comapnyName, finalStation: finalStation)
                    oneStageInformationBuses.append(oneStageInformationBus)
                }
            }
        }
        
        return oneStageInformationBuses
    }
    
    
    fileprivate func parseJSON(busRoute: String?, completion: (_ jsonArr: NSArray) -> ()) {
        let path = Bundle.main.path(forResource: busRoute , ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let jsonArr = jsonData as! NSArray
            completion(jsonArr)
        } catch let error {
            print("Failed to access local JSON file",error)
        }
    }
    
    
    
    fileprivate func searchStationsInSameLine(startStation: String, endStation: String, day: String, hour: Int, minute: Int) -> BusInformation?{
        var busRoute: BusRoute?
        var busInfomation: BusInformation?
        if let startIndex = northernStations.firstIndex(of: startStation), let endIndex = northernStations.firstIndex(of: endStation){
            let value = startIndex - endIndex
            if value > 0{
                busRoute = NorthRouteContent.North_to_East.rawValue
            }else{
                busRoute = NorthRouteContent.East_to_North.rawValue
            }
        }else if let startIndex = westernStations.firstIndex(of: startStation), let endIndex = westernStations.firstIndex(of: endStation){
            let value = startIndex - endIndex
            if value > 0{
                busRoute = WestRouteContent.West_to_East.rawValue
            }else{
                busRoute = WestRouteContent.East_to_West.rawValue
                
            }
        }else if let startIndex = southernStations.firstIndex(of: startStation), let endIndex = southernStations.firstIndex(of: endStation){
            let value = startIndex - endIndex
            if value > 0{
                busRoute = SouthRouteContent.South_to_East.rawValue
                
            }else{
                busRoute = SouthRouteContent.East_to_South.rawValue
            }
        }
        guard let innerBusRoute = busRoute else {return nil}
        busInfomation = BusInformation.init(busRoute: innerBusRoute, startStation: startStation, endStation: endStation, day: day, hour: hour, minute: minute)
        return busInfomation
    }
    
    fileprivate func searchStationsInDifferentLine(startStation: String, endStation: String, day: String, hour: Int, minute: Int) -> TwoBusInformations{
        var twoStagesInfo: TwoStagesInfo
        var firstStageRoute = String()
        var startStationForFirstStage = String()
        var endStationForFirstStage = String()
        var firstBusInformation: BusInformation
        
        var secondStageRoute = String()
        var startStationForSecondStage = String()
        var endStationForSecondStage = String()
        var secondBusInformation: BusInformation
        
        //如果startStation在Northern
        if let _ = northernStations.firstIndex(of: startStation){
            firstStageRoute = NorthRouteContent.North_to_East.rawValue
            startStationForFirstStage = startStation
            if let _ = westernStations.firstIndex(of: endStation){
                //如果endStation在西方
                endStationForFirstStage = NorthenBusStations.belizeCity.rawValue
                secondStageRoute = WestRouteContent.East_to_West.rawValue
//                startStationForSecondStage = WesternBusStations.belizeCity.rawValue
                startStationForSecondStage = endStationForFirstStage
                endStationForSecondStage = endStation
            }else{
                //如果endStation在南方
                endStationForFirstStage = NorthenBusStations.belizeCity.rawValue
                secondStageRoute = SouthRouteContent.East_to_South.rawValue
//                startStationForSecondStage = SouthernBusStations.belizeCity.rawValue
                startStationForSecondStage = endStationForFirstStage
                endStationForSecondStage = endStation
            }
            
            
        }else if let _ = westernStations.firstIndex(of: startStation){
            //如果startStation在Western
            firstStageRoute = WestRouteContent.West_to_East.rawValue
            startStationForFirstStage = startStation
            
            if let _ = northernStations.firstIndex(of: endStation){
                //如果endStation在北方
                endStationForFirstStage = WesternBusStations.belizeCity.rawValue
                secondStageRoute = NorthRouteContent.East_to_North.rawValue
//                startStationForSecondStage = NorthenBusStations.belizeCity.rawValue
                startStationForSecondStage = endStationForFirstStage
                endStationForSecondStage = endStation
            }else{
                //如果endStation在南方
                endStationForFirstStage = WesternBusStations.belmopan.rawValue
                secondStageRoute = SouthRouteContent.East_to_South.rawValue
//                startStationForSecondStage = SouthernBusStations.belmopan.rawValue
                startStationForSecondStage = endStationForFirstStage
                endStationForSecondStage = endStation
            }
            
            
        }else if let _ = southernStations.firstIndex(of: startStation){
            //如果startStation在Southern
            firstStageRoute = SouthRouteContent.South_to_East.rawValue
            startStationForFirstStage = startStation
            if let _ = northernStations.firstIndex(of: endStation){
                //如果endStation在北方
                endStationForFirstStage = SouthernBusStations.belizeCity.rawValue
                secondStageRoute = NorthRouteContent.East_to_North.rawValue
//                startStationForSecondStage = NorthenBusStations.belizeCity.rawValue
                startStationForSecondStage = endStationForFirstStage
                endStationForSecondStage = endStation
            }else{
                //如果endStation在西方
                endStationForFirstStage = SouthernBusStations.belmopan.rawValue
                secondStageRoute = WestRouteContent.East_to_West.rawValue
//                startStationForSecondStage = WesternBusStations.belmopan.rawValue
                startStationForSecondStage = endStationForFirstStage
                endStationForSecondStage = endStation
            }
        }
        twoStagesInfo = (firstStageRoute, startStationForFirstStage, endStationForFirstStage, secondStageRoute, startStationForSecondStage, endStationForSecondStage)
        
        firstBusInformation = BusInformation.init(busRoute: twoStagesInfo.0, startStation: twoStagesInfo.1, endStation: twoStagesInfo.2, day: day, hour: hour, minute: minute)
        secondBusInformation = BusInformation.init(busRoute: twoStagesInfo.3, startStation: twoStagesInfo.4, endStation: twoStagesInfo.5, day: day, hour: hour, minute: minute)
        
        
        return (firstBusInformation, secondBusInformation)
    }
}
