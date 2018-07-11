//
//  Extension_ItinerarySelectionPickerView_UIPickerView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension ItinerarySelectionPickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let busStaions = busStations else {
            return 0
        }
        return busStaions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let busStaions = busStations else {
            return nil
        }
        return busStaions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let busStaions = busStations else {return}
        
        if component == 0{
            startStation = busStaions[row]
            indexOfStartStation = row
        }else{
            endStation = busStaions[row]
            indexOfEndStation = row
        }
        
        
    }
}
