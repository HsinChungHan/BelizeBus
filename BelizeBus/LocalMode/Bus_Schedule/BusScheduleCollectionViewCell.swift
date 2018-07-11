//
//  BusScheduleCollectionViewCell.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/15.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class BusScheduleCollectionViewCell: BasicCell {
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
    
    let backgroundImgView: UIImageView = {
       let imv = UIImageView()
        imv.contentMode = .scaleAspectFit
        imv.image = UIImage(named: "BBOC_bus")
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
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.layer.cornerRadius = 2.0
        label.clipsToBounds = true
        return label
    }()
    
    
    let destinationLabel: UILabel = {
        let label = UILabel()
        label.text = "to Bancaye"
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let startStationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.classicDarkBlack
        label.text = "Belize City"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let endStationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.classicDarkBlack
        label.text = "Belmopan"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let startTimeUpLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.lightRed
        label.text = "13:00"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let startTimeDownLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.text = "13:00"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    
    let endTimeLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.darkGray
        label.text = "15:00"
        label.font = UIFont.boldSystemFont(ofSize: 12)
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
    
    
    func setupAllViews(){
        addSubview(timeLineView)
        timeLineView.widthAnchor.constraint(equalToConstant: self.frame.width * 3 / 4).isActive = true
        timeLineView.heightAnchor.constraint(equalToConstant: self.frame.height / 2 - 20).isActive = true
        timeLineView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        timeLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -frame.height / 4 - 5).isActive = true
        
        addSubview(busTypeLabel)
        busTypeLabel.anchor(top: topAnchor, bottom: timeLineView.topAnchor, left: timeLineView.leftAnchor, right: nil, topPadding: 20, bottomPadding: 5, leftPadding: 0, rightPadding: 0, width: 30, height: 0)
        
        addSubview(startTimeUpLabel)
        startTimeUpLabel.anchor(top: busTypeLabel.topAnchor, bottom: busTypeLabel.bottomAnchor, left: busTypeLabel.rightAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 60, height: 0)
        
        addSubview(destinationLabel)
        destinationLabel.anchor(top: startTimeUpLabel.topAnchor, bottom: startTimeUpLabel.bottomAnchor, left: nil, right: timeLineView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 150, height: 0)
        
        
        timeLineView.addSubview(startStationLabel)
        timeLineView.addSubview(leftGrayDotView)
        timeLineView.addSubview(startTimeDownLabel)

       startStationLabel.anchor(top: timeLineView.topAnchor, bottom: nil, left: timeLineView.leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 100, height: (timeLineView.frame.height) / 3)
        
        leftGrayDotView.centerYAnchor.constraint(equalTo: timeLineView.centerYAnchor).isActive = true
        leftGrayDotView.centerXAnchor.constraint(equalTo: startStationLabel.centerXAnchor).isActive = true
        leftGrayDotView.widthAnchor.constraint(equalToConstant: 6).isActive = true
        leftGrayDotView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        leftGrayDotView.layoutIfNeeded()
        leftGrayDotView.layer.cornerRadius = leftGrayDotView.frame.height/2
        
        startTimeDownLabel.anchor(top: nil, bottom: timeLineView.bottomAnchor, left: startStationLabel.leftAnchor, right: startStationLabel.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: (timeLineView.frame.height) / 3)
        
        
        timeLineView.addSubview(endStationLabel)
        timeLineView.addSubview(rightGrayDotView)
        timeLineView.addSubview(endTimeLabel)
        endStationLabel.anchor(top: startStationLabel.topAnchor, bottom: startStationLabel.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        endStationLabel.rightAnchor.constraint(equalTo: timeLineView.rightAnchor).isActive = true
        endStationLabel.widthAnchor.constraint(equalTo: startStationLabel.widthAnchor, multiplier: 1).isActive = true
        
        rightGrayDotView.anchor(top: leftGrayDotView.topAnchor, bottom: leftGrayDotView.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        rightGrayDotView.widthAnchor.constraint(equalTo: leftGrayDotView.widthAnchor, multiplier: 1).isActive = true
        rightGrayDotView.centerXAnchor.constraint(equalTo: endStationLabel.centerXAnchor).isActive = true
        rightGrayDotView.layoutIfNeeded()
        rightGrayDotView.layer.cornerRadius = rightGrayDotView.frame.height /
2
        endTimeLabel.anchor(top: startTimeDownLabel.topAnchor, bottom: startTimeDownLabel.bottomAnchor, left: nil, right: endStationLabel.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        endTimeLabel.widthAnchor.constraint(equalTo: startTimeDownLabel.widthAnchor, multiplier: 1).isActive = true
        
        timeLineView.addSubview(grayLineView)
        grayLineView.anchor(top: nil, bottom: nil, left: leftGrayDotView.rightAnchor, right: rightGrayDotView.leftAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 2, rightPadding: 2, width: 0, height: 2)
        grayLineView.centerYAnchor.constraint(equalTo: timeLineView.centerYAnchor).isActive = true
    }
    
    func setInformation(startTimeUpText: String, startTimeDownText: String, endTimeText: String,  startStation: String, endStation: String) {
        startTimeUpLabel.text = startTimeUpText
        startTimeDownLabel.text = startTimeDownText
        endTimeLabel.text = endTimeText
        startStationLabel.text = startStation
        endStationLabel.text = endStation
    }
    
    override func setupViews() {
        self.backgroundColor = UIColor.clear
        self.backgroundView = backgroundImgView
        setupAllViews()
    }
    
    
}
