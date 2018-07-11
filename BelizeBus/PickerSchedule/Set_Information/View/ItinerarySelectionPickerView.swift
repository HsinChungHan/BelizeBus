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
