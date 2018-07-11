//
//  BasicTableViewCell.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/13.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.classicBrown
        return label
    }()
    
    func setupViews() {
        backgroundColor = UIColor.darkGray
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        titleLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: nil, topPadding: 10, bottomPadding: 10, leftPadding: 20, rightPadding: 0, width: 120, height: 0)
        subTitleLabel.anchor(top: titleLabel.topAnchor, bottom: titleLabel.bottomAnchor, left: titleLabel.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 20, rightPadding: 10, width: 0, height: 0)
    }
    
   
}
