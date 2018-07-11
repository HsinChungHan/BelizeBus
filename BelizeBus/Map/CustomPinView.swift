//
//  CustomPinView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/5/24.
//  Copyright © 2018年 辛忠翰. All rights reserved.
//

import UIKit
import MapKit
protocol CustomPinViewDelegate {
    func addStartPoint()
    func addEndPoint()
}



class CustomPinView: BasicView {
    var station: BusStation?{
        didSet{
            stationImageView.image = station?.image
            titleLabel.text = station?.name
//            addressLabel.text =
        }
    }
    
    var customPinViewDelegate: CustomPinViewDelegate?
    
    var stationImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Name"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var startButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.appleGreen
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(addStartPoint), for: .touchUpInside)
        return btn
    }()
    
    lazy var endButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("End", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.skyBlue
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(addEndPoint), for: .touchUpInside)
        return btn
    }()
    
    override func setupViews() {
        addSubview(stationImageView)
        addSubview(titleLabel)
        addSubview(addressLabel)
        addSubview(startButton)
        addSubview(endButton)
        stationImageView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, topPadding: 20, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: 25, height: 25)
        titleLabel.anchor(top: stationImageView.topAnchor, bottom: stationImageView.bottomAnchor, left: stationImageView.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 20, width: 0, height: 0)
        addressLabel.anchor(top: stationImageView.bottomAnchor, bottom: nil, left: stationImageView.leftAnchor, right: titleLabel.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 20)
        startButton.anchor(top: addressLabel.bottomAnchor, bottom: self.bottomAnchor, left: addressLabel.leftAnchor, right: nil, topPadding: 10, bottomPadding: 20, leftPadding: 0, rightPadding: 0, width: 50, height: 0)
        endButton.anchor(top: startButton.topAnchor, bottom: startButton.bottomAnchor, left: nil, right: addressLabel.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 50, height: 0)
    }

}


extension CustomPinView{
    @objc func addStartPoint(){
        customPinViewDelegate?.addStartPoint()
    }
    
    @objc func addEndPoint(){
        customPinViewDelegate?.addEndPoint()
    }
}
