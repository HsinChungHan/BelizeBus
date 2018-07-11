//
//  Extension_PickerViewController.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

extension PickerViewController{
    func fetchBustRoute(){
        guard let busRoute = scheduleView.busRoute else {
            return
        }
        self.busRoute = busRoute
    }
    
    
    func parseJSON(busRoute: String?, completion: (_ jsonArr: NSArray) -> ()) {
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
    
    func searchSchedule(busInformation: BusInformation){
        let startStation = busInformation.startStation
        let endStation = busInformation.endStation
        let day = busInformation.day
        let hour = String(busInformation.hour)
        var northernSchedules = [NorthernBusSchedule]()
        var westernSchedules = [WesternBusSchedule]()
        var southernSchedules = [SouthernBusSchedule]()
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
                if item.fetchSchedule(startStation: startStation, endStation: endStation, day: day, hour: hour){
                    print("northernSchedules")
                    print(item.fetchValue(index: startStation))
                    print(item.fetchValue(index: endStation))
                    print("---------------------------")
                    newNorthernSchedules.append(item)
                }
            }
        }else if !southernSchedules.isEmpty{
            for (index, item) in southernSchedules.enumerated(){
                if item.fetchSchedule(startStation: startStation, endStation: endStation, day: day, hour: hour){
                    print("southernSchedules")
                    print(item.fetchValue(index: startStation))
                    print(item.fetchValue(index: endStation))
                    print("---------------------------")
                    newSouthernSchedules.append(item)
                }
            }
        }else if !westernSchedules.isEmpty{
            for (index, item) in westernSchedules.enumerated(){
                if item.fetchSchedule(startStation: startStation, endStation: endStation, day: day, hour: hour){
                    print("westernSchedules")
                    print(item.fetchValue(index: startStation))
                    print(item.fetchValue(index: endStation))
                    print("---------------------------")
                    newWesternSchedules.append(item)
                }
            }
        }
        
    }
    
    func setupView() {
        view.addSubview(scheduleView)
        scheduleView.fullAnchor(superView: view)
    }
    
    
    func doneButtonItemDisabled() {
        rightBarButtonItem = UIBarButtonItem(title: NaviItemLabelText.DoneItem.rawValue , style: .plain, target: self, action: #selector(handleDoneItem))
        rightBarButtonItem?.setTitleTextAttributes(
            [
                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: DoneBtnStyle.Disable.set.size),
                NSAttributedStringKey.foregroundColor: DoneBtnStyle.Disable.set.color
            ]
            , for: .normal )
        rightBarButtonItem?.isEnabled = DoneBtnStyle.Disable.set.isUserInteract
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupNaviStyle() {
        navigationItem.title = NaviTitle.SetInformation.rawValue
        
        //設定bar的背景顏色
        navigationController?.navigationBar.barTintColor = UIColor.classicDarkGreen
        doneButtonItemDisabled()
    }
    
    
    
    
    @objc func handleDoneItem(){
        guard let startStation = scheduleView.busStartStation,
            let endStation = scheduleView.busEndStation,
            let busRoute = scheduleView.busRoute,
            let day = scheduleView.busStartDay,
            let hour = scheduleView.busStartHour
            else {
                return
        }
        print("busRoute: ",busRoute)
        print("startStation: ",startStation)
        print("endStation: ",endStation)
        print("day: ",day)
        print("hour: ",hour)
        busInformation = BusInformation.init(busRoute: busRoute, startStation: startStation, endStation: endStation, day: day, hour: hour)
        
        searchSchedule(busInformation: busInformation!)
        
        
        let vc = BusScheduleViewController()
        vc.busInformation = busInformation
        if !newNorthernSchedules.isEmpty{
            vc.northernSchedules = newNorthernSchedules
        }else if !newSouthernSchedules.isEmpty{
            vc.southernSchedules = newSouthernSchedules
        }else if !newWesternSchedules.isEmpty{
            vc.westernSchedules = newWesternSchedules
        }
        let naviVC = CustomNavigationController.init(rootViewController: vc)
        naviVC.transitioningDelegate = slideRightTransitionAnimator
        present(naviVC, animated: true){ [weak self] in
            self?.northernSchedules.removeAll()
            self?.newNorthernSchedules.removeAll()
            self?.southernSchedules.removeAll()
            self?.newSouthernSchedules.removeAll()
            self?.westernSchedules.removeAll()
            self?.newWesternSchedules.removeAll()
        }
    }
    
    func setupRightBarButtonItem(btnStyle: DoneBtnStyle){
        let rightBarButtonItem = UIBarButtonItem(title: NaviItemLabelText.DoneItem.rawValue, style: .plain, target: self, action: #selector(handleDoneItem))
        rightBarButtonItem.setTitleTextAttributes(
            [
                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: btnStyle.set.size),
                NSAttributedStringKey.foregroundColor: btnStyle.set.color
            ]
            , for: .normal )
        navigationItem.rightBarButtonItem = rightBarButtonItem
        rightBarButtonItem.isEnabled = btnStyle.set.isUserInteract
    }
    
}
