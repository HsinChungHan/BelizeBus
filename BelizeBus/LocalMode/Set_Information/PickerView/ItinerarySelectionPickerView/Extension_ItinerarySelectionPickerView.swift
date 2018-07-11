//
//  Extension_ItinerarySelectionPickerView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension ItinerarySelectionPickerView{
    func compareStartAndEndStation() {
        if startStation != endStation{
            doneButton.isUserInteractionEnabled = true
            doneButton.setTitleColor(UIColor.darkOrange, for: .normal)
        }else{
            doneButton.isUserInteractionEnabled = false
            doneButton.setTitleColor(UIColor.classicBrown, for: .normal)
        }
    }
    
    func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    
    
    @objc func dismissSelectionPickerView(){
        guard let startStation = startStation, let endStation = endStation, let busRoute = recognizeBusRoute() else {return}
        fetchFinalBusRouteDelegate?.fetchFinalBusRoute(busRoute: busRoute)
        setItineraryLabelDelegate?.setItineraryLabel(start: startStation, end: endStation)
        let transform = CGAffineTransform(translationX: 0, y: ViewConstant.SelectionPickerViewHeight.rawValue)
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            self.layoutIfNeeded()
            self.transform = transform
        }, completion: nil)
    }
    
    //Northern: value > 0, North_to_East; value < 0, East_to_North
    //Western: value > 0, West_to_East; value < 0, East_to_West
    //Southern: value > 0, South_to_East; value < 0, East_to_South
    
    func recognizeBusRoute() -> String?{
        guard let busArea = busArea else {return nil}
        let value = indexOfStartStation - indexOfEndStation
        switch busArea {
        case JSONDirectionContent.Northern.rawValue:
            if value > 0{
                return NorthRouteContent.North_to_East.rawValue
            }else{
                return NorthRouteContent.East_to_North.rawValue
            }
        case JSONDirectionContent.Western.rawValue:
            if value > 0{
                return WestRouteContent.West_to_East.rawValue
            }else{
                return WestRouteContent.East_to_West.rawValue
                
            }
        case JSONDirectionContent.Southern.rawValue:
            if value > 0{
                return SouthRouteContent.South_to_East.rawValue
            }else{
                return SouthRouteContent.East_to_South.rawValue
            }
        default:
            return nil
        }
    }
}
