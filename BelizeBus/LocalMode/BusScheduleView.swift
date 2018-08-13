//
//  BusScheduleView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/25.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class BusScheduleView: BasicView {
    var busInformation: BusInformation?{
        didSet{
            
        }
    }
    
    var northernSchedule: NorthernBusSchedule?{
        didSet{
            guard let startTime = northernSchedule?.fetchValue(index: (busInformation?.startStation)!) else {return}
            guard let endTime = northernSchedule?.fetchValue(index: (busInformation?.endStation)!) else {return}
            setInformation(startTimeUpText: startTime, startTimeDownText: startTime, endTimeText: endTime, startStation: (busInformation?.startStation)!, endStation: (busInformation?.endStation)!)
        }
    }
    var westernSchedule: WesternBusSchedule?{
        didSet{
            guard let startTime = westernSchedule?.fetchValue(index: (busInformation?.startStation)!) else {return}
            guard let endTime = westernSchedule?.fetchValue(index: (busInformation?.endStation)!) else {return}
            setInformation(startTimeUpText: startTime, startTimeDownText: startTime, endTimeText: endTime, startStation: (busInformation?.startStation)!, endStation: (busInformation?.endStation)!)
        }
    }
    var southernSchedule: SouthernBusSchedule?{
        didSet{
            guard let startTime = southernSchedule?.fetchValue(index: (busInformation?.startStation)!) else {return}
            guard let endTime = southernSchedule?.fetchValue(index: (busInformation?.endStation)!) else {return}
            setInformation(startTimeUpText: startTime, startTimeDownText: startTime, endTimeText: endTime, startStation: (busInformation?.startStation)!, endStation: (busInformation?.endStation)!)
        }
    }
    
    var innerView: UIView = {
       let view = UIView()
        return view
    }()
    
    var backgroundImgView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFit
        imv.image = UIImage(named: "Default")
        return imv
    }()
    
    let timeLineView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 3.0
        iv.clipsToBounds = true
        return iv
    }()
    
    let busTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Reg"
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.darkOrange
        label.textAlignment = .center
//        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.font = UIFont.boldSystemFont(ofSize: 28)

        label.layer.cornerRadius = 2.0
        label.clipsToBounds = true
        return label
    }()
    
    
    let destinationLabel: UILabel = {
        let label = UILabel()
        label.text = "to Belize City"
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
//        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.font = UIFont.boldSystemFont(ofSize: 40)

        
        return label
    }()
    
    let startStationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.classicDarkBlack
        label.text = "Belize City"
        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.systemFont(ofSize: 24)

        return label
    }()
    
    let endStationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.classicDarkBlack
        label.text = "Belmopan"
//        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.systemFont(ofSize: 24)

        label.textAlignment = .center
        return label
    }()
    
    let startTimeUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightRed
        label.text = "13:00"
        label.textAlignment = .center
//        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.font = UIFont.boldSystemFont(ofSize: 40)

        label.textAlignment = .center
        return label
    }()
    
    let startTimeDownLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.text = "13:00"
//        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.font = UIFont.boldSystemFont(ofSize: 24)

        label.textAlignment = .center
        return label
    }()
    
    
    let endTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.text = "15:00"
//        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.font = UIFont.boldSystemFont(ofSize: 24)

        label.textAlignment = .center
        return label
    }()
    
    let leftGrayDotView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightGrayDotView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    let grayLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    let defaultBusCompanyLabel: UILabel = {
        let label = UILabel()
        label.text = "Default"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    override func setupViews() {
//        self.backgroundColor =
        self.backgroundColor = UIColor.clear
        setupAllViews()
    }
   

}


extension BusScheduleView{
    fileprivate func setupAllViews(){
        addSubview(backgroundImgView)
        backgroundImgView.fullAnchor(superView: self)
        
        addSubview(innerView)
        //IPhone
//        innerView.anchor(top: backgroundImgView.topAnchor, bottom: nil, left: backgroundImgView.leftAnchor, right: backgroundImgView.rightAnchor, topPadding: 13, bottomPadding: 30, leftPadding: 85, rightPadding: 10, width: 0, height: 70)
        
        //IPad
        innerView.anchor(top: backgroundImgView.topAnchor, bottom: nil, left: backgroundImgView.leftAnchor, right: backgroundImgView.rightAnchor, topPadding: 13, bottomPadding: 30, leftPadding: 170, rightPadding: 30, width: 0, height: 140)
        
        innerView.layoutIfNeeded()
        innerView.addSubview(timeLineView)
        timeLineView.anchor(top: nil, bottom: innerView.bottomAnchor, left: innerView.leftAnchor, right: innerView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: innerView.frame.height/2 + 5)
        
        innerView.addSubview(busTypeLabel)
        busTypeLabel.anchor(top: innerView.topAnchor, bottom: timeLineView.topAnchor, left: timeLineView.leftAnchor, right: nil, topPadding: 0, bottomPadding: 8, leftPadding: 0, rightPadding: 0, width: 120, height: 0)
        innerView.addSubview(startTimeUpLabel)
        //IPhone
//        startTimeUpLabel.anchor(top: busTypeLabel.topAnchor, bottom: busTypeLabel.bottomAnchor, left: busTypeLabel.rightAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 60, height: 0)
        startTimeUpLabel.anchor(top: busTypeLabel.topAnchor, bottom: busTypeLabel.bottomAnchor, left: busTypeLabel.rightAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 0, height: 0)
        startTimeUpLabel.sizeToFit()
        
        innerView.addSubview(destinationLabel)
        destinationLabel.anchor(top: busTypeLabel.topAnchor, bottom: busTypeLabel.bottomAnchor, left: startTimeUpLabel.rightAnchor, right: innerView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 0, height: 0)
        
        
        
        timeLineView.addSubview(startStationLabel)
        timeLineView.addSubview(leftGrayDotView)
        timeLineView.addSubview(startTimeDownLabel)
        
        startStationLabel.anchor(top: timeLineView.topAnchor, bottom: nil, left: timeLineView.leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 200, height: (timeLineView.frame.height) / 3)
        startTimeDownLabel.layoutIfNeeded()
        
        leftGrayDotView.centerYAnchor.constraint(equalTo: timeLineView.centerYAnchor).isActive = true
        leftGrayDotView.anchor(top: nil, bottom: nil, left: innerView.leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 30, rightPadding: 0, width: 6, height: 6)
        leftGrayDotView.layoutIfNeeded()
        leftGrayDotView.setCorner(radius: leftGrayDotView.frame.width/2)
        
        //IPhone
//        startTimeDownLabel.anchor(top: nil, bottom: timeLineView.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 60, height: (timeLineView.frame.height) / 3)
//        startTimeDownLabel.centerXAnchor.constraint(equalTo: leftGrayDotView.centerXAnchor).isActive = true
//        startTimeDownLabel.layoutIfNeeded()
        startTimeDownLabel.anchor(top: nil, bottom: timeLineView.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: (timeLineView.frame.height) / 3)
        startTimeDownLabel.centerXAnchor.constraint(equalTo: leftGrayDotView.centerXAnchor).isActive = true
        startTimeDownLabel.sizeToFit()
        startTimeDownLabel.layoutIfNeeded()
        
        
        timeLineView.addSubview(endStationLabel)
        timeLineView.addSubview(rightGrayDotView)
        timeLineView.addSubview(endTimeLabel)
        endStationLabel.anchor(top: startStationLabel.topAnchor, bottom: startStationLabel.bottomAnchor, left: nil, right: innerView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 10, width: startStationLabel.frame.width, height: 0)
        
        rightGrayDotView.anchor(top: leftGrayDotView.topAnchor, bottom: leftGrayDotView.bottomAnchor, left: nil, right: innerView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 30, width: leftGrayDotView.frame.width, height: leftGrayDotView.frame.height)
        rightGrayDotView.layoutIfNeeded()
        rightGrayDotView.setCorner(radius: rightGrayDotView.frame.width/2)
        
        
        //Iphone
//        endTimeLabel.anchor(top: startTimeDownLabel.topAnchor, bottom: startTimeDownLabel.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: startTimeDownLabel.frame.width, height: 0)
//        endTimeLabel.centerXAnchor.constraint(equalTo: rightGrayDotView.centerXAnchor).isActive = true
        endTimeLabel.anchor(top: startTimeDownLabel.topAnchor, bottom: startTimeDownLabel.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        endTimeLabel.sizeToFit()
        endTimeLabel.centerXAnchor.constraint(equalTo: rightGrayDotView.centerXAnchor).isActive = true
        
        
        
        timeLineView.addSubview(grayLineView)
        grayLineView.anchor(top: nil, bottom: nil, left: leftGrayDotView.rightAnchor, right: rightGrayDotView.leftAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 2, rightPadding: 2, width: 0, height: 2)
        grayLineView.centerYAnchor.constraint(equalTo: timeLineView.centerYAnchor).isActive = true
    }
    
    func setupDefaultBusCompanyLabel(companyName: String) {
        addSubview(defaultBusCompanyLabel)
        defaultBusCompanyLabel.anchor(top: nil, bottom: timeLineView.topAnchor, left: leftAnchor, right: timeLineView.leftAnchor, topPadding: 0, bottomPadding: -5, leftPadding: 25, rightPadding: 8, width: 0, height: 32)
        defaultBusCompanyLabel.text = companyName
        defaultBusCompanyLabel.layoutIfNeeded()
//        defaultBusCompanyLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    
    
    func setInformation(startTimeUpText: String, startTimeDownText: String, endTimeText: String,  startStation: String, endStation: String) {
        startTimeUpLabel.text = startTimeUpText
        startTimeDownLabel.text = startTimeDownText
        endTimeLabel.text = endTimeText
        startStationLabel.text = startStation
        endStationLabel.text = endStation
    }
    
    func setupViewValue(stageInformation: OneStageBusInformation){
        let startStation = stageInformation.startStation
        let startTime = stageInformation.startTime
        let endStation = stageInformation.endStation
        let endTime = stageInformation.endTime
        let busType = stageInformation.busType
        let finalStation = stageInformation.finalStation
        let company = stageInformation.companyName
        busTypeLabel.text = busType
        startTimeUpLabel.text = startTime
        destinationLabel.text = finalStation
        startStationLabel.text = startStation
        startTimeDownLabel.text = startTime
        endStationLabel.text = endStation
        endTimeLabel.text = endTime
        if AllBusStation.checkBusCompanyArray(companyName: company){
            backgroundImgView.image = UIImage(named: company)
            defaultBusCompanyLabel.removeFromSuperview()
        }else{
            backgroundImgView.image = UIImage(named: BusCompanyImageName.Bus_default.rawValue)
            setupDefaultBusCompanyLabel(companyName: company)
        }
    }
}
