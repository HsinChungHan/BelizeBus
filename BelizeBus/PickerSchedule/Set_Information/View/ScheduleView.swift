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

extension ScheduleView{
    func registerCell(){
        tableView.register(ItineraryTableViewCell.self, forCellReuseIdentifier: CellId.ItineraryID.rawValue)
        tableView.register(BusRouteTableViewCell.self, forCellReuseIdentifier: CellId.BusRouteID.rawValue)
        tableView.register(OutboundTableViewCell.self, forCellReuseIdentifier: CellId.OutboundID.rawValue)
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.fullAnchor(superView: self)
        tableView.isScrollEnabled = false
    }
    
    func setupTableViewStyle(){
        tableView.backgroundColor = UIColor.classicDarkBlack
        tableView.separatorColor = .white
        let blankView = UIView(frame: .zero)
        tableView.tableFooterView = blankView
        
    }
    
    
    func setupSelectionPickerView() {
        addSubview(itinerarySelectionPickerView)
        addSubview(outboundSelectionPickerView)
        itinerarySelectionPickerView.anchor(top: bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: ViewConstant.SelectionPickerViewHeight.rawValue)
        outboundSelectionPickerView.anchor(top: bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: ViewConstant.SelectionPickerViewHeight.rawValue)
        
    }

    func setupValues() {
        outboundSubtitleLabelText = SubtilteLabelBasicContent.Outbound.rawValue
        itinerarySubtitleLabelText = SubtilteLabelBasicContent.Itinerary.rawValue
    }
    
    func setupBlackView() {
        self.addSubview(blackView)
        blackView.fullAnchor(superView: self)
    }
    
    func disappearBlackView(){
        UIView.animate(withDuration: 1.5, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[weak self] in
            self?.blackView.alpha = 0
        })
    }
}



extension ScheduleView: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellId.BusRouteID.rawValue , for: indexPath) as! BusRouteTableViewCell
            busRouteTableViewCell = cell
            cell.segmentedContolView.delegate = self
            cell.setupViews()
            cell.selectionStyle = .none
            busRoute = cell.segmentedContolView.currentValue ?? "North"
            return cell
            
        }else if indexPath.item == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellId.ItineraryID.rawValue , for: indexPath) as! ItineraryTableViewCell
            itineraryTableViewCell = cell
            cell.setupViews()
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellId.OutboundID.rawValue , for: indexPath) as! OutboundTableViewCell
            outboundTableViewCell = cell
            cell.setupViews()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        decideDoneBtnDelegate?.disebleDoneState()
        let transform = CGAffineTransform(translationX: 0, y: -ViewConstant.SelectionPickerViewHeight.rawValue)
        
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
                if indexPath.item == 1{
                    self.blackView.alpha = 1.0
                    self.itinerarySelectionPickerView.transform = transform
                    self.itinerarySelectionPickerView.setItineraryLabelDelegate = self
                }else if indexPath.item == 2{
                    self.blackView.alpha = 1.0
                    self.outboundSelectionPickerView.transform = transform
                    self.outboundSelectionPickerView.delegate = self
                }
                
            }, completion: nil)
    }
    
    
}


extension ScheduleView: SetDateLabelDelegate{
    func setDateLabel(date: String, day: String, hour: String) {
        disappearBlackView()
        guard let outboundTableViewCell = outboundTableViewCell else {
            return
        }
        outboundTableViewCell.subTitleLabel.text = date
        outboundTableViewCell.subTitleLabel.textColor = UIColor.darkOrange.withAlphaComponent(0.6)
        outboundSubtitleLabelText = date
        busStartDay = day
        busStartHour = Int(hour)
    }
    
}

extension ScheduleView: SetItineraryLabelDelegate{
    func setItineraryLabel(start: String, end: String) {
        disappearBlackView()
        guard let itineraryTableViewCell = itineraryTableViewCell else {return}
        let startToEnd = "\(start) -> \(end)"
        itineraryTableViewCell.subTitleLabel.text = startToEnd
        itineraryTableViewCell.subTitleLabel.textColor = UIColor.darkOrange.withAlphaComponent(0.6)
        itinerarySubtitleLabelText = startToEnd
        busStartStation = start
        busEndStation = end
    }
}

extension ScheduleView: ChangeBusRouteProtocol{
    func changeBusRoute(currentValue: String) {
        busRoute = currentValue
    }
}
