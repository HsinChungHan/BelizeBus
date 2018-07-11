//
//  BusRouteTableViewCell.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/13.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit


class BusRouteTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TitleLabelBasicContent.BusRoute.rawValue
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    
    let segmentedContolView: SegmentedContolView = {
        let scv = SegmentedContolView()
        return scv
    }()
    
    func setupViews() {
        backgroundColor = UIColor.darkGray
        addSubview(titleLabel)
        addSubview(segmentedContolView)
        titleLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: nil, topPadding: 10, bottomPadding: 10, leftPadding: 20, rightPadding: 0, width: 120, height: 0)
        segmentedContolView.anchor(top: topAnchor, bottom: bottomAnchor, left: titleLabel.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 20, rightPadding: 10, width: 0, height: 0)
        
    }
    
    
}
