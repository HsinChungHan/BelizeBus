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

        return busStations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return busStations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            startStation = busStations[row]
        }else{
            endStation = busStations[row]
        }
    }
}
