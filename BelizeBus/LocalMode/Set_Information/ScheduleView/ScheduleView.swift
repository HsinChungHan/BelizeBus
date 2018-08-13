//
//  ScheduleView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit


protocol DecideDoneBtnStateDlegate{
    func changeDoneState(isEnable: Bool)
    func disebleDoneState()
}

protocol FetchBusRouteDelegate {
    func fetchBusRoute(busRoute: String)
}

class ScheduleView: BasicView {
    var busStartStation: String?
    var busEndStation: String?
    var busStartHour: Int?
    var busStartMinute: Int?
    var busStartDay: String?
    var busRoute: String?{
        didSet{
            guard let busRoute = busRoute else {return}
            fetchBusRouteDelegate?.fetchBusRoute(busRoute: busRoute)
        }
    }
    
    lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightBlackColor
        view.alpha = 0
        return view
    }()
    var decideDoneBtnDelegate: DecideDoneBtnStateDlegate?
    var fetchBusRouteDelegate: FetchBusRouteDelegate?
    func decideDoneBtnState() {
        if outboundSubtitleLabelText != SubtilteLabelBasicContent.Outbound.rawValue && itinerarySubtitleLabelText != SubtilteLabelBasicContent.Itinerary.rawValue{
            decideDoneBtnDelegate?.changeDoneState(isEnable: true)
        }else{
            decideDoneBtnDelegate?.changeDoneState(isEnable: false)
        }
    }
    var itineraryTableViewCell: ItineraryTableViewCell?
    var outboundTableViewCell: OutboundTableViewCell?
    var busRouteTableViewCell: BusRouteTableViewCell?
    
    var outboundSubtitleLabelText: String?{
        didSet{
            decideDoneBtnState()
        }
    }
    
    var itinerarySubtitleLabelText: String?{
        didSet{
            decideDoneBtnState()
        }
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    let itinerarySelectionPickerView: ItinerarySelectionPickerView = {
        let spv = ItinerarySelectionPickerView()
        return spv
    }()
    
    let outboundSelectionPickerView: OutboundSelectionPickerView = {
        let ospv = OutboundSelectionPickerView()
        return ospv
    }()
    override func setupViews() {
        registerCell()
        setupTableView()
        setupTableViewStyle()
        setupBlackView()
        setupSelectionPickerView()
        setupValues()
    }
}












