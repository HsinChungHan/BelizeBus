//
//  IndexViewController.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/24.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

extension DateFormatter{
    func fetchDateStr(date: Date, format: String) -> String {
        self.dateFormat = format
        return self.string(from: date)
    }
}


class IndexViewController: UIViewController {
//    var doneBarButtonItem: UIBarButtonItem?
    let borderBrownColor = UIColor.rgb(red: 181, green: 143, blue: 132)
    let backgroundBrownColor = UIColor.rgb(red: 249, green: 227, blue: 190)
    let disableButtonColor = UIColor.hex(hex: "#B58F84")
    
    
    var date: String?, day: String?, hour: Int?, startStation: String?, endStation: String?, minute: Int?, time: String?
    var busInformation: BusInformation?
    
    lazy var chooseStationView: UIView = {
       let view = UIView()
        view.backgroundColor = backgroundBrownColor
        view.layer.borderWidth = 1.0
        view.layer.borderColor = borderBrownColor.cgColor
        return view
    }()
    
    lazy var seperatedView: UIView = {
       let view = UIView()
        view.backgroundColor = borderBrownColor
        return view
    }()
    
    
    lazy var startStationView: SelectedInformationView = {
        let siv = SelectedInformationView()
        siv.imgName = "place"
        siv.title = SubtilteLabelBasicContent.ChooseStartStation.rawValue
        siv.isUserInteractionEnabled = true
        let tapGesureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSelectedStations))
        siv.addGestureRecognizer(tapGesureRecognizer)
        return siv
    }()
    
    lazy var endStationView: SelectedInformationView = {
        let siv = SelectedInformationView()
        siv.imgName = "place"
        siv.title = SubtilteLabelBasicContent.ChooseEndStation.rawValue
        siv.isUserInteractionEnabled = true
        let tapGesureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSelectedStations))
        siv.addGestureRecognizer(tapGesureRecognizer)
        return siv
    }()
    
    
    
    lazy var swapButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "switch")?.withRenderingMode(.alwaysOriginal) , for: .normal)
        btn.addTarget(self, action: #selector(handleSwap), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    
    lazy var timeView: SelectedInformationView = {
        let siv = SelectedInformationView()
        siv.imgName = "time"
        siv.isUserInteractionEnabled = true
        let tapGesureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTime))
        siv.addGestureRecognizer(tapGesureRecognizer)
        siv.backgroundColor = backgroundBrownColor
        let currentTime = Date()
        let allDateTime = DateFormatter().fetchDateStr(date: currentTime, format: "EEE HH:mm")
        let hourMinTime = DateFormatter().fetchDateStr(date: currentTime, format: "HH:mm")
        let wholeDate = DateFormatter().fetchDateStr(date: currentTime, format: "yyyy/MM/dd, EEE, HH:mm")
        siv.title = allDateTime
        date = wholeDate
        day  = allDateTime.fetchPrefix(fromChar: " ")
        guard let currentHour = hourMinTime.fetchPrefix(fromChar: ":"), let currentMin = hourMinTime.fetchSuffix(fromChar: ":") else {return siv}
        hour = Int(currentHour)
        minute = Int(currentMin)
        time = allDateTime
        return siv
    }()
    
    lazy var searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Search", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btn.setTitleColor(disableButtonColor, for: .normal)
//        btn.setTitleColor(UIColor.classicDarkGreen, for: .normal)
        btn.alpha = 0.0
        btn.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    
    
    lazy var outboundSelectionPickerView: OutboundSelectionPickerView = {
       let ospv = OutboundSelectionPickerView()
        ospv.delegate = self
        return ospv
    }()
    
    lazy var itinerarySelectionPickerView: ItinerarySelectionPickerView = {
       let ispv = ItinerarySelectionPickerView()
        ispv.setItineraryLabelDelegate = self
        return ispv
    }()
    
    lazy var blackView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.lightBlackColor
        view.alpha = 0.0
        view.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissBlackView))
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNaviStyle()
        setupBlackView()
    }
}


extension IndexViewController{
    
    
    fileprivate func setupViews(){
        view.backgroundColor = UIColor.backgroundRiceColor
        setupChooseStationView()
        setupSwapButton()
        setupTimeView()
        setupSearchButton()
        setupSelectionPickerView()
        
    }
    
    fileprivate func setupChooseStationView(){
        view.addSubview(chooseStationView)
        chooseStationView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topPadding: 90, bottomPadding: 0, leftPadding: 30, rightPadding: 30, width: 0, height: 160)
        chooseStationView.layoutIfNeeded()
        chooseStationView.setCorner(radius: 10)
        chooseStationView.addSubview(seperatedView)
        chooseStationView.setShadow(shadowColor: UIColor.lightGray, shadowOpacity: 0.5, offsetWidth: 10, offsetHeight: 10)
        seperatedView.anchor(top: nil, bottom: nil, left: chooseStationView.leftAnchor, right: chooseStationView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 1)
        seperatedView.centerYAnchor.constraint(equalTo: chooseStationView.centerYAnchor).isActive = true
        setupStartAndEndViews()
    }
    
    fileprivate func setupStartAndEndViews(){
        chooseStationView.addSubview(startStationView)
        chooseStationView.addSubview(endStationView)
        startStationView.anchor(top: chooseStationView.topAnchor, bottom: seperatedView.topAnchor, left: chooseStationView.leftAnchor, right: chooseStationView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        endStationView.anchor(top: seperatedView.bottomAnchor, bottom: chooseStationView.bottomAnchor, left: chooseStationView.leftAnchor, right: chooseStationView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
    }
    
    fileprivate func setupSwapButton(){
        chooseStationView.addSubview(swapButton)
        swapButton.centerYAnchor.constraint(equalTo: chooseStationView.centerYAnchor).isActive = true
        swapButton.anchor(top: nil, bottom: nil, left: nil, right: chooseStationView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 30, width: 45, height: 45)
        swapButton.layoutIfNeeded()
        swapButton.setCorner(radius: swapButton.frame.width/2)
        swapButton.setShadow(shadowColor: UIColor.lightGray, shadowOpacity: 0.5, offsetWidth: 5, offsetHeight: 5)
    }
    
    fileprivate func setupTimeView(){
        view.addSubview(timeView)
        timeView.anchor(top: chooseStationView.bottomAnchor, bottom: nil, left: chooseStationView.leftAnchor, right: chooseStationView.rightAnchor, topPadding: 55, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: chooseStationView.frame.height/2)
        timeView.layoutIfNeeded()
        timeView.layer.borderWidth = chooseStationView.layer.borderWidth
        timeView.layer.borderColor = chooseStationView.layer.borderColor
        timeView.setCorner(radius: chooseStationView.layer.cornerRadius)
        timeView.setShadow(shadowColor: UIColor.lightGray, shadowOpacity: 0.5, offsetWidth: 10, offsetHeight: 10)
    }
    
    fileprivate func setupSearchButton(){
        view.addSubview(searchButton)
        searchButton.anchor(top: timeView.bottomAnchor, bottom: nil, left: nil, right: timeView.rightAnchor, topPadding: 55, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 150, height: 60)
        searchButton.setCorner(radius: 10.0)
        let backGroundLayer = CAGradientLayer()
        backGroundLayer.setGradientLayer(view: searchButton, colors: [
            UIColor.bigButtonUpGradientColor,
            UIColor.bigButtonDownGradientColor
            ], cornerRadius: 10.0)
        
    }
    
    
    
    fileprivate func setupNaviStyle() {
        navigationItem.title = NaviTitle.IndexTitle.rawValue
        //設定bar的背景顏色
//        navigationController?.navigationBar.barTintColor = UIColor.lightGray
//        setupDoneButtonDisabled()
    }
    
    
//    fileprivate func setupDoneButtonDisabled(){
//        doneBarButtonItem = UIBarButtonItem(title: NaviItemLabelText.DoneItem.rawValue , style: .plain, target: self, action: #selector(handleDoneItem))
//        doneBarButtonItem?.setTitleTextAttributes(
//            [
//                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: DoneBtnStyle.Disable.set.size),
//                NSAttributedStringKey.foregroundColor: DoneBtnStyle.Disable.set.color
//            ]
//            , for: .normal )
//        doneBarButtonItem?.isEnabled = DoneBtnStyle.Disable.set.isUserInteract
//        navigationItem.rightBarButtonItem = doneBarButtonItem
//    }
    
//    fileprivate func setupDoneButtonEnabled(){
//        doneBarButtonItem = UIBarButtonItem(title: NaviItemLabelText.DoneItem.rawValue , style: .plain, target: self, action: #selector(handleDoneItem))
//        doneBarButtonItem?.setTitleTextAttributes(
//            [
//                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: DoneBtnStyle.Enable.set.size),
//                NSAttributedStringKey.foregroundColor: DoneBtnStyle.Enable.set.color
//            ]
//            , for: .normal )
//        doneBarButtonItem?.isEnabled = DoneBtnStyle.Enable.set.isUserInteract
//        navigationItem.rightBarButtonItem = doneBarButtonItem
//    }
    
    @objc func handleDoneItem(){
        let searchAlgo = SearchSchedulesAlgorithm()
        guard let startStation = startStation, let endStation = endStation, let day = day, let hour = hour, let minute = minute, let time = time else {return}
        //searchSchedulsForTwoStations回傳(schedules, isTwoStages)
        let searchResult = searchAlgo.searchSchedulsForTwoStations(startStation: startStation, endStation: endStation, day: day, hour: hour, minute: minute)
        
        guard let sechedules = searchResult.0, let isTwoStage = searchResult.1 else {return}
        let transportedStation = searchResult.2
        
        for sechedule in sechedules{
            print(sechedule.firstStageBusInformation)
            print(sechedule.secondStageBusInformation)
            print("----------------------------")
        }
        
        let indexPageInformation = IndexPageInformation(startStation: startStation, endStation: endStation, transportedStation: transportedStation, time: time)
        
        let resultVC = ResultViewController()
        resultVC.isTwoStages = transportedStation != nil ? true : false
        resultVC.initValue(schedules: sechedules, indexPageInformation: indexPageInformation)
        let naviVC = UINavigationController(rootViewController: resultVC)
        present(naviVC, animated: true, completion: nil)
    }
    
    @objc func handleSelectedStations(){
        
        slideUpPickerView(selectionPickerView: itinerarySelectionPickerView)
        itinerarySelectionPickerView.isSlidedUp = true
    }
    
    @objc func handleSwap(){
        let startTitle = startStationView.title
        startStationView.title = endStationView.title
        endStationView.title = startTitle
        startStation = startStationView.title
        endStation = endStationView.title
        guard let startStation = startStation, let endStation = endStation else {
            return
        }
        itinerarySelectionPickerView.selectedValueForPickerView(startStation: startStation, endStation: endStation)
        itinerarySelectionPickerView.setupStartAndEndStation(startStation: startStation, endStation: endStation)
    }
    
    @objc func handleTime(){
        slideUpPickerView(selectionPickerView: outboundSelectionPickerView)
        outboundSelectionPickerView.isSlidedUp = true
    }
    
    @objc func handleSearch(){
        let searchAlgo = SearchSchedulesAlgorithm()
        guard let startStation = startStation, let endStation = endStation, let day = day, let hour = hour, let minute = minute, let time = time else {return}
        //searchSchedulsForTwoStations回傳(schedules, isTwoStages)
        let searchResult = searchAlgo.searchSchedulsForTwoStations(startStation: startStation, endStation: endStation, day: day, hour: hour, minute: minute)
        
        guard let sechedules = searchResult.0, let isTwoStage = searchResult.1 else {return}
        let transportedStation = searchResult.2
        
        for sechedule in sechedules{
            print(sechedule.firstStageBusInformation)
            print(sechedule.secondStageBusInformation)
            print("----------------------------")
        }
        
        let indexPageInformation = IndexPageInformation(startStation: startStation, endStation: endStation, transportedStation: transportedStation, time: time)
        
        let resultVC = ResultViewController()
        resultVC.isTwoStages = transportedStation != nil ? true : false
        resultVC.initValue(schedules: sechedules, indexPageInformation: indexPageInformation)
        let naviVC = UINavigationController(rootViewController: resultVC)
        present(naviVC, animated: true, completion: nil)
    }
    
    
    @objc func dismissBlackView(){
        disappearBlackView()
        if outboundSelectionPickerView.isSlidedUp{
            outboundSelectionPickerView.isSlidedUp = false
            slideDownPickerView(selectionPickerView: outboundSelectionPickerView)
        }else{
            itinerarySelectionPickerView.isSlidedUp = false
            slideDownPickerView(selectionPickerView: itinerarySelectionPickerView)
        }
//        checkDoneStatus()
        guard let startStation = startStation, let endStation = endStation else {return}
        itinerarySelectionPickerView.selectedValueForPickerView(startStation: startStation, endStation: endStation)
        itinerarySelectionPickerView.setupStartAndEndStation(startStation: startStation, endStation: endStation)
    }
    
    func setupSelectionPickerView() {
        view.addSubview(outboundSelectionPickerView)
        outboundSelectionPickerView.anchor(top: view.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: ViewConstant.SelectionPickerViewHeight.rawValue)
        view.addSubview(itinerarySelectionPickerView)
        itinerarySelectionPickerView.anchor(top: view.bottomAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: ViewConstant.SelectionPickerViewHeight.rawValue)
    }
    
    func setupBlackView() {
        view.insertSubview(blackView, belowSubview: outboundSelectionPickerView)
        blackView.fullAnchor(superView: view)
    }
    
    func disappearBlackView(){
        UIView.animate(withDuration: 1.5, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[weak self] in
            self?.blackView.alpha = 0
        })
    }
    
    func slideUpPickerView(selectionPickerView: UIView){
        let transform = CGAffineTransform(translationX: 0, y: -ViewConstant.SelectionPickerViewHeight.rawValue)
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.blackView.alpha = 1.0
            selectionPickerView.transform = transform
        }, completion: {[weak self] (_) in
//            self?.doneBarButtonItem?.isEnabled = DoneBtnStyle.Disable.set.isUserInteract
        })
        
    }
    
    func slideDownPickerView(selectionPickerView: UIView){
        let transform = CGAffineTransform(translationX: 0, y: ViewConstant.SelectionPickerViewHeight.rawValue)
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            selectionPickerView.transform = transform
        }, completion: {[weak self]  (_) in
//            self?.checkDoneStatus()
        })
    }
    
//    fileprivate func checkDoneStatus(){
//        if startStationView.titleLabel.text != SubtilteLabelBasicContent.Itinerary.rawValue &&
//        endStationView.titleLabel.text != SubtilteLabelBasicContent.Itinerary.rawValue {
//            setupDoneButtonEnabled()
//        }else{
//            setupDoneButtonDisabled()
//        }
//    }
    
    fileprivate func checkSearchStatus(){
        if startStationView.titleLabel.text != SubtilteLabelBasicContent.Itinerary.rawValue &&
            endStationView.titleLabel.text != SubtilteLabelBasicContent.Itinerary.rawValue {
            setupSearchButtonEnabled()
        }else{
            setupSearchButtonDisabled()
        }
    }
    
    fileprivate func setupSearchButtonEnabled(){
        searchButton.setShadow(shadowColor: UIColor.lightGray, shadowOpacity: 0.5, offsetWidth: 10.0, offsetHeight: 10.0)
        searchButton.setTitleColor(UIColor.backgroundRiceColor, for: .normal)
        searchButton.isEnabled = true
        searchButton.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            self.searchButton.alpha = 1.0
        }
    }
    
    fileprivate func setupSearchButtonDisabled(){
        searchButton.setTitleColor(disableButtonColor, for: .normal)
        searchButton.isEnabled = false
        searchButton.alpha = 1.0
        UIView.animate(withDuration: 1.0) {
            self.searchButton.alpha = 0.0
        }
    }
}


extension IndexViewController: SetDateLabelDelegate{
    func setDateLabel(date: String, day: String, hour: String, minute: String) {
        disappearBlackView()
        timeView.title = "\(day)  \(hour):\(minute)"
        outboundSelectionPickerView.isSlidedUp = false
//        checkDoneStatus()
        checkSearchStatus()
        self.date = date
        self.day = day
        self.hour = Int(hour)
        self.minute = Int(minute)
        self.time = "\(day)  \(hour):\(minute)"
    }
    
    
}

extension IndexViewController: SetItineraryLabelDelegate{
    func setItineraryLabel(start: String, end: String) {
        disappearBlackView()
        startStationView.title = start
        endStationView.title = end
//        checkDoneStatus()
        checkSearchStatus()
        swapButton.isEnabled = true
        self.startStation = start
        self.endStation = end
    }
}
