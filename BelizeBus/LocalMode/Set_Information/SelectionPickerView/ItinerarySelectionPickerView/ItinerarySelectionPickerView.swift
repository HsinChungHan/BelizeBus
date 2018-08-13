//
//  ItinerarySelectionPickerView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/13.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
protocol SetItineraryLabelDelegate {
    func setItineraryLabel(start: String, end: String)
}

protocol FetchFinalBusRouteDelegate {
    func fetchFinalBusRoute(busRoute: String)
}

class ItinerarySelectionPickerView: BasicSelectionPickerView {
    var setItineraryLabelDelegate: SetItineraryLabelDelegate?
    var fetchFinalBusRouteDelegate: FetchFinalBusRouteDelegate?
    var isSlidedUp = false
    
    var busStations: [String] = AllBusStation.allStations()
    
    var startStation: String?{
        didSet{
            compareStartAndEndStation()
        }
    }
    
    var endStation: String?{
        didSet{
            compareStartAndEndStation()
        }
    }
    
    
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    
    
    
    
    
    
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.white
        super.setupLabelTitle(leftText: TitleOfLabel.ItineraryFromLabel.rawValue , rightText: TitleOfLabel.ItineraryToLabel.rawValue)
        setupPickerView()
        addAllSubview()
        setupDoneButtonProperties()
        selectedDefaultValueForPickerView()
    }
    
    
    
    
}





