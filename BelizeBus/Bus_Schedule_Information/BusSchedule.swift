//
//  BusScgedule.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/19.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
class BusSchedule {
    let direction, comapnyName, daysOperation, busType: String
    let dict: [String: Any]
    
    init(direction: String, dict: [String : Any]) {
        self.direction = direction
        self.comapnyName = dict[BusScheduleConstant.companyName.rawValue] as? String ?? ""
        self.daysOperation = dict[BusScheduleConstant.daysOperation.rawValue] as? String ?? ""
        self.busType = dict[BusScheduleConstant.busType.rawValue] as? String ?? ""
        self.dict = dict
    }
    
    func fetchValue(index: String) -> String?{
        return nil
    }
    
    func fetchFinalBusStation() -> String?{
        return nil
    }
    
    func fetchSchedule(startStation: String, endStation: String, day: String, hour: String, minute: String) -> Bool{
        guard
            let startTime = fetchValue(index: startStation),
            let startTimeHourStr = startTime.fetchPrefix(fromChar: ":"),
            let startTimeHour = Int(startTimeHourStr),
            let startTimeMinuteStr = startTime.fetchSuffix(fromChar: ":"),
            let startTimeMinute = Int(startTimeMinuteStr),
            let userStartTimeHour = Int(hour),
            let userStartTimeMinute = Int(minute),
            let endTime = fetchValue(index: endStation)
            else {
                return false
        }
        
        if !startTime.isEmpty && !endTime.isEmpty{
            if startTimeHour > userStartTimeHour{
                var thefullyDays = ""
                
                switch self.daysOperation{
                case DaysOperation.MonFriConstant.rawValue:
                    thefullyDays = DaysOperation.MonFri.rawValue
                case DaysOperation.MonSatConstant.rawValue:
                    thefullyDays = DaysOperation.MonSat.rawValue
                case DaysOperation.MonSunConstant.rawValue:
                    thefullyDays = DaysOperation.MonSun.rawValue
                case DaysOperation.Sat.rawValue:
                    thefullyDays = DaysOperation.Sat.rawValue
                case DaysOperation.Sun.rawValue:
                    thefullyDays = DaysOperation.Sun.rawValue
                case DaysOperation.MonThurConstant.rawValue:
                    thefullyDays = DaysOperation.MonThur.rawValue
                default:
                    thefullyDays = ""
                }
                if thefullyDays.contains(day){
                    return true
                }
            }else if startTimeHour == userStartTimeHour{
                if startTimeMinute > userStartTimeMinute || startTimeMinute == userStartTimeMinute{
                    var thefullyDays = ""
                    
                    switch self.daysOperation{
                    case DaysOperation.MonFriConstant.rawValue:
                        thefullyDays = DaysOperation.MonFri.rawValue
                    case DaysOperation.MonSatConstant.rawValue:
                        thefullyDays = DaysOperation.MonSat.rawValue
                    case DaysOperation.MonSunConstant.rawValue:
                        thefullyDays = DaysOperation.MonSun.rawValue
                    case DaysOperation.Sat.rawValue:
                        thefullyDays = DaysOperation.Sat.rawValue
                    case DaysOperation.Sun.rawValue:
                        thefullyDays = DaysOperation.Sun.rawValue
                    case DaysOperation.MonThurConstant.rawValue:
                        thefullyDays = DaysOperation.MonThur.rawValue
                    default:
                        thefullyDays = ""
                    }
                    if thefullyDays.contains(day){
                        return true
                    }
                }
            }
        }
        return false
    }
    
    
}
