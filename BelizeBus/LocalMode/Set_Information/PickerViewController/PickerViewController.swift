//
//  PickerViewController.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit


class PickerViewController: UIViewController {
    let slideRightTransitionAnimator = SlideRightTransitionAnimator()
    var rightBarButtonItem: UIBarButtonItem?
    
    var northernSchedules = [NorthernBusSchedule]()
    var westernSchedules = [WesternBusSchedule]()
    var southernSchedules = [SouthernBusSchedule]()
    var newNorthernSchedules = [NorthernBusSchedule]()
    var newWesternSchedules = [WesternBusSchedule]()
    var newSouthernSchedules = [SouthernBusSchedule]()
    var busRoute: String?
    
    var busInformation: BusInformation?
    
    lazy var scheduleView: ScheduleView = {
        let view = ScheduleView()
        view.decideDoneBtnDelegate = self
        view.fetchBusRouteDelegate = self
        view.itinerarySelectionPickerView.fetchFinalBusRouteDelegate = self
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNaviStyle()
    }
    
}












