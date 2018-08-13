//
//  TimeView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/25.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class TimeView: BasicView {
    
    let timeLabel: UILabel = {
       let label = UILabel()
        label.text = "23:00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    override func setupViews() {
        addSubview(timeLabel)
        timeLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 5, width: 0, height: 0)
    }

}

extension TimeView{
    public func setupViewValues(time: String){
        timeLabel.text = time
    }
}
