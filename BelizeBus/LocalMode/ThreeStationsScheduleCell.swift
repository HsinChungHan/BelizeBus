//
//  ThreeStationsScheduleCell.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/25.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ThreeStationsScheduleCell: BasicTBCell {
    let darkTextBrownColor = UIColor.rgb(red: 132, green: 94, blue: 85)
    let lightTextBrownColor = UIColor.rgb(red: 157, green: 117, blue: 107)
    let darkBackGroundColor = UIColor.rgb(red: 132, green: 94, blue: 85)
    let lightBackGroundColor = UIColor.rgb(red: 181, green: 143, blue: 132)
    let arrorBrownColor = UIColor.rgb(red: 157, green: 117, blue: 107)
    
    let diractionImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "closed")
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    
    
    lazy var seperatedView: UIView = {
       let view = UIView()
        view.backgroundColor = lightBackGroundColor
        return view
    }()
    
    lazy var leftView: TimeView = {
        let view = TimeView()
        view.backgroundColor = darkBackGroundColor
        return view
    }()
    
    lazy var middleView: TimeView = {
        let view = TimeView()
        view.backgroundColor = lightBackGroundColor
        return view
    }()
    
    lazy var rightView: TimeView = {
        let view = TimeView()
        view.backgroundColor = lightBackGroundColor
        return view
    }()
    
    lazy var firstArrorLabel: UILabel = {
       let label = UILabel()
       label.text = ">>"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = arrorBrownColor
        return label
    }()
    
    lazy var secondArrorLabel: UILabel = {
        let label = UILabel()
        label.text = ">>"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = arrorBrownColor
        return label
    }()
    
    let busesView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.darkBlueColor
        return view
    }()
    
    lazy var firstStageBusView: BusScheduleView = {
       let bsv = BusScheduleView()
        return bsv
    }()
    
    lazy var secondStageBusView: BusScheduleView = {
        let bsv = BusScheduleView()
        return bsv
    }()
    
    //為了讓cell有間距
    override var frame: CGRect{
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.size.height -= 20
            super.frame = frame
        }
    }
    
    let view1: UIView = {
       let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    let view2: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    override func setupViews() {
        setCellStyle()
        setupDiratcionImgView()
        setupSeperatedLine()
        setupCubeViews()
        setupArrorsLabels()
        setupStageBusesView()
        
    }
    
    
   
    
}


extension ThreeStationsScheduleCell{
    fileprivate func setCellStyle() {
        selectionStyle = .none
        setCorner(radius: 10)
    }
    
    
    public func setupDiratcionImgView(){
        addSubview(diractionImgView)
        diractionImgView.anchor(top: topAnchor, bottom: nil, left: nil, right: rightAnchor, topPadding: 5, bottomPadding: 0, leftPadding: 0, rightPadding: 5, width: 25, height: 25)
    }
    
    fileprivate func setupSeperatedLine(){
        addSubview(seperatedView)
        seperatedView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 75, bottomPadding: 0, leftPadding: 26, rightPadding: 26, width: 0, height: 2)
    }
    
    fileprivate func setupCubeViews(){
        addSubview(leftView)
        addSubview(middleView)
        addSubview(rightView)
        leftView.anchor(top: nil, bottom: seperatedView.topAnchor, left: seperatedView.leftAnchor, right: nil, topPadding: 0, bottomPadding: 2, leftPadding: 5, rightPadding: 0, width: 80, height: 45)
        leftView.layoutIfNeeded()
        leftView.setCorner(radius: 2.0)
        leftView.setShadow(shadowColor: UIColor.lightGray, shadowOpacity: 0.8, offsetWidth: 8, offsetHeight: 8)
//        let leftViewShadow = leftView.getShadowArguments()
        
        middleView.anchor(top: nil, bottom: seperatedView.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: leftView.frame.width, height: leftView.frame.height)
        middleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        middleView.layoutIfNeeded()
        middleView.setCorner(radius: leftView.layer.cornerRadius)
        
//        middleView.setShadow(shadowColor: leftViewShadow.shadowColor , shadowOpacity: leftViewShadow.shadowOpacity, offsetWidth: leftViewShadow.offsetWidth, offsetHeight: leftViewShadow.offsetHeight)
        
        rightView.anchor(top: nil, bottom: seperatedView.topAnchor, left: nil, right: seperatedView.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 5, width: leftView.frame.width, height: leftView.frame.height)
        rightView.setCorner(radius: leftView.layer.cornerRadius)
        
    }
    
    fileprivate func setupArrorsLabels(){
        addSubview(firstArrorLabel)
        addSubview(secondArrorLabel)
        firstArrorLabel.anchor(top: nil, bottom: nil, left: leftView.rightAnchor, right: middleView.leftAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 8, rightPadding: 8, width: 0, height: 22)
        firstArrorLabel.centerYAnchor.constraint(equalTo: middleView.centerYAnchor).isActive = true
        firstArrorLabel.layoutIfNeeded()
        secondArrorLabel.anchor(top: firstArrorLabel.topAnchor, bottom: firstArrorLabel.bottomAnchor, left: middleView.rightAnchor, right: rightView.leftAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 8, rightPadding: 8, width: firstArrorLabel.frame.width, height: firstArrorLabel.frame.height)
    }
    
    fileprivate func setupStageBusesView(){
        addSubview(busesView)
        busesView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 102, bottomPadding: 10, leftPadding: 5, rightPadding: 5, width: 0, height: 0)
        busesView.layoutIfNeeded()
        busesView.addSubview(firstStageBusView)
        busesView.addSubview(secondStageBusView)
        busesView.setCorner(radius: 10)
        
        //IPhine版型
        firstStageBusView.anchor(top: busesView.topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 15, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 110)
        secondStageBusView.anchor(top: firstStageBusView.bottomAnchor, bottom: nil, left: firstStageBusView.leftAnchor, right: firstStageBusView.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0 , height: 110)
//        firstStageBusView.anchor(top: busesView.topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 15, bottomPadding: 0, leftPadding: 20, rightPadding: 10, width: 0, height: 220)
//        secondStageBusView.anchor(top: firstStageBusView.bottomAnchor, bottom: nil, left: firstStageBusView.leftAnchor, right: firstStageBusView.rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0 , height: 220)
    }
    
    
    fileprivate func removeMiddleViewAndSecondStageView(){
        middleView.removeFromSuperview()
        secondStageBusView.removeFromSuperview()
    }
    
    public func setupViewValues(isTwoStages: Bool, startStation: String, startTime: String, endStation: String, endTime: String, busType: String, finalStation: String){
       
        leftView.setupViewValues(time: startTime)
        rightView.setupViewValues(time: endTime)
        if !isTwoStages{
            removeMiddleViewAndSecondStageView()
        }
    }
    
    public func setupViewValues(firstStageInformation: OneStageBusInformation, sencondStageInfornmation: OneStageBusInformation?){
        setupTimeView(firstStageInformation: firstStageInformation, sencondStageInfornmation: sencondStageInfornmation)
        setupBusesValue(firstStageInformation: firstStageInformation, sencondStageInfornmation: sencondStageInfornmation)
    }
    
    
    fileprivate func setupTimeView(firstStageInformation: OneStageBusInformation, sencondStageInfornmation: OneStageBusInformation?){
        if let sencondStageInfornmation = sencondStageInfornmation{
            //有two stages
            let startTime = firstStageInformation.startTime
            let transportedTime = firstStageInformation.endTime
            let endTime = sencondStageInfornmation.endTime
            leftView.setupViewValues(time: startTime)
            middleView.setupViewValues(time: transportedTime)
            rightView.setupViewValues(time: endTime)
        }else{
            //無two stages
            let startTime = firstStageInformation.startTime
            let endTime = firstStageInformation.endTime
            leftView.setupViewValues(time: startTime)
            rightView.setupViewValues(time: endTime)
            middleView.removeFromSuperview()
            secondArrorLabel.removeFromSuperview()
            firstArrorLabel.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true
            firstArrorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            
        }
    }
    
    fileprivate func setupBusesValue(firstStageInformation: OneStageBusInformation, sencondStageInfornmation: OneStageBusInformation?){
        firstStageBusView.setupViewValue(stageInformation: firstStageInformation)
        if let sencondStageInfornmation = sencondStageInfornmation{
            //有two stages
            secondStageBusView.setupViewValue(stageInformation: sencondStageInfornmation)
        }
    }
}
