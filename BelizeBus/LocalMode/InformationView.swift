//
//  InformationView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/25.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit


class InformationView: BasicView {
    let textBrownColor = UIColor.rgb(red: 132, green: 94, blue: 85)
    let barBackGroundColor = UIColor.rgb(red: 181, green: 143, blue: 132)
    let labelTextColor = UIColor.rgb(red: 157, green: 117, blue: 107)
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Tuesday 9:00"
        label.textColor = textBrownColor
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    lazy var barView: UIView = {
       let view = UIView()
        view.backgroundColor = barBackGroundColor
        return view
    }()
    
    let whitePointLeft: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    let whitePointMiddle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    let whitePointRight: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    lazy var startLabel: UILabel = {
       let label = UILabel()
        label.text = "Corozal"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = labelTextColor
        label.font = UIFont.italicSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var middleLabel: UILabel = {
        let label = UILabel()
        label.text = "Belize City"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = labelTextColor
        label.font = UIFont.italicSystemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var endLabel: UILabel = {
        let label = UILabel()
        label.text = "Punta Gorda"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = labelTextColor
        label.font = UIFont.italicSystemFont(ofSize: 20)
        return label
    }()
    
    override func setupViews() {
        setupTimeLabel()
        setupBarView()
        setupStationsLabel()
    }
}

extension InformationView{
    fileprivate func setupTimeLabel(){
        addSubview(timeLabel)
        timeLabel.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 54)
    }
    
    fileprivate func setupBarView(){
        addSubview(barView)
        barView.anchor(top: timeLabel.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 56, rightPadding: 56, width: 0, height: 38)
        barView.layoutIfNeeded()
        barView.layer.cornerRadius = barView.frame.height / 2
        barView.clipsToBounds = true
        
        barView.addSubview(whitePointLeft)
        barView.addSubview(whitePointMiddle)
        barView.addSubview(whitePointRight)
        whitePointLeft.centerYAnchor.constraint(equalTo: barView.centerYAnchor).isActive = true
        whitePointLeft.anchor(top: nil, bottom: nil, left: barView.leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 16, rightPadding: 0, width: 16, height: 16)
        whitePointLeft.layoutIfNeeded()
        whitePointMiddle.anchor(top: whitePointLeft.topAnchor, bottom: whitePointLeft.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: whitePointLeft.frame.width, height: 0)
        whitePointMiddle.centerXAnchor.constraint(equalTo: barView.centerXAnchor).isActive = true
        whitePointMiddle.layoutIfNeeded()
        whitePointRight.anchor(top: whitePointLeft.topAnchor, bottom: whitePointLeft.bottomAnchor, left: nil, right: barView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 16, width: whitePointLeft.frame.width, height: 0)
        whitePointRight.layoutIfNeeded()
        whitePointLeft.layer.cornerRadius = whitePointLeft.frame.width / 2
        whitePointMiddle.layer.cornerRadius = whitePointMiddle.frame.width / 2
        whitePointRight.layer.cornerRadius = whitePointRight.frame.width / 2
    }
    
    fileprivate func setupStationsLabel(){
        addSubview(startLabel)
        addSubview(middleLabel)
        addSubview(endLabel)
        startLabel.anchor(top: barView.bottomAnchor, bottom: bottomAnchor, left: nil, right: nil, topPadding: 10, bottomPadding: 8, leftPadding: 0, rightPadding: 0, width: 80, height: 0)
        startLabel.centerXAnchor.constraint(equalTo: whitePointLeft.centerXAnchor).isActive = true
        startLabel.layoutIfNeeded()
        
        middleLabel.anchor(top: startLabel.topAnchor, bottom: startLabel.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: startLabel.frame.width, height: 0)
        middleLabel.centerXAnchor.constraint(equalTo: whitePointMiddle.centerXAnchor).isActive = true
        
        endLabel.anchor(top: startLabel.topAnchor, bottom: startLabel.bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: startLabel.frame.width, height: 0)
        endLabel.centerXAnchor.constraint(equalTo: whitePointRight.centerXAnchor).isActive = true
    }
    
    fileprivate func removeMiddleView(){
        whitePointMiddle.removeFromSuperview()
        middleLabel.removeFromSuperview()
    }
    
    public func setupViewValues(isTwoStages: Bool, time: String, startStation: String, endStation: String, transportedStation: String?){
        if !isTwoStages{
            removeMiddleView()
        }
        timeLabel.text = time
        startLabel.text = startStation
        endLabel.text = endStation
        guard let transportedStation = transportedStation else {return}
        middleLabel.text = transportedStation
    }
    
}



