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
    var indexOfStartStation = 0
    var indexOfEndStation = 0
    var setItineraryLabelDelegate: SetItineraryLabelDelegate?
    var fetchFinalBusRouteDelegate: FetchFinalBusRouteDelegate?
    
    var busStations: [String]?
    var busArea: String?{
        didSet{
            guard let busRoute = busArea else {return}
            switch busRoute {
            case JSONDirectionContent.Northern.rawValue:
               busStations = AllBusStation.setNorthStations()
               pickerView.reloadAllComponents()
              
            case JSONDirectionContent.Western.rawValue:
                busStations = AllBusStation.setWestStations()
               pickerView.reloadAllComponents()
            case JSONDirectionContent.Southern.rawValue:
                busStations = AllBusStation.setSouthStations()
                pickerView.reloadAllComponents()
            default:
                break
            }
            pickerView.selectRow(0, inComponent: 0, animated: true)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            startStation = busStations?[0]
            endStation = busStations?[0]
        }
    }
    
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
    
    let northStations = NorthernBusSchedule.setNorthStations()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    
    
    fileprivate func setupDoneButtonProperties() {
        doneButton.addTarget(self, action: #selector(dismissSelectionPickerView), for: .touchUpInside)
        doneButton.isUserInteractionEnabled = false
        doneButton.setTitleColor(UIColor.classicBrown , for: .normal)
    }
    
    fileprivate func setupValue() {
        startStation = northStations[0]
        endStation = northStations[0]
    }
    
    override func setupViews() {
        super.setupViews()
        super.setupLabelTitle(leftText: TitleOfLabel.ItineraryFromLabel.rawValue , rightText: TitleOfLabel.ItineraryToLabel.rawValue)
        backgroundColor = UIColor.white
        setupPickerView()
        addAllSubview()
        setupDoneButtonProperties()
        setupValue()
    }
    
    
    
    func addAllSubview() {
        addSubview(pickerView)
        pickerView.anchor(top: doneButton.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 40, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        leftLabel.anchor(top: nil, bottom: pickerView.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 100, height: 25)
        leftLabel.centerXAnchor.constraint(equalTo: leftDummyView.centerXAnchor).isActive = true
        
        rightLabel.anchor(top: nil, bottom: pickerView.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 100, height: 25)
        rightLabel.centerXAnchor.constraint(equalTo: rightDummyView.centerXAnchor).isActive = true
        
    }
}





