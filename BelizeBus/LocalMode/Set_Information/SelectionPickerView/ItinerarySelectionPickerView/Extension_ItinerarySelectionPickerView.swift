//
//  Extension_ItinerarySelectionPickerView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension ItinerarySelectionPickerView{
    func addAllSubview() {
        addSubview(pickerView)
        pickerView.anchor(top: doneButton.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 40, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        leftLabel.anchor(top: nil, bottom: pickerView.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 100, height: 25)
        leftLabel.centerXAnchor.constraint(equalTo: leftDummyView.centerXAnchor).isActive = true
        
        rightLabel.anchor(top: nil, bottom: pickerView.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 100, height: 25)
        rightLabel.centerXAnchor.constraint(equalTo: rightDummyView.centerXAnchor).isActive = true
    }
    
    func setupDoneButtonProperties() {
        doneButton.addTarget(self, action: #selector(dismissSelectionPickerView), for: .touchUpInside)
        doneButton.isUserInteractionEnabled = false
        doneButton.setTitleColor(UIColor.classicBrown , for: .normal)
    }
    
    func setupStartAndEndStation(startStation: String, endStation: String){
        self.startStation = startStation
        self.endStation = endStation
    }
    
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
    
    func selectedDefaultValueForPickerView() {
        pickerView.selectRow(Int(busStations.count/2), inComponent: 0, animated: true)
        pickerView.selectRow(Int(busStations.count/2), inComponent: 1, animated: true)
        startStation = busStations[Int(busStations.count/2)]
        endStation = busStations[Int(busStations.count/2)]
    }
    
    func selectedValueForPickerView(startStation: String, endStation: String){
        guard
            let startIndex = busStations.firstIndex(of: startStation),
            let endIndex = busStations.firstIndex(of: endStation)
        else{return}
        pickerView.selectRow(startIndex, inComponent: 0, animated: true)
        pickerView.selectRow(endIndex, inComponent: 1, animated: true)
    }
    
    @objc func dismissSelectionPickerView(){
        guard let startStation = startStation, let endStation = endStation else {return}
        
        setItineraryLabelDelegate?.setItineraryLabel(start: startStation, end: endStation)
        let transform = CGAffineTransform(translationX: 0, y: ViewConstant.SelectionPickerViewHeight.rawValue)
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            self.layoutIfNeeded()
            self.transform = transform
        }, completion: nil)
    }
}
