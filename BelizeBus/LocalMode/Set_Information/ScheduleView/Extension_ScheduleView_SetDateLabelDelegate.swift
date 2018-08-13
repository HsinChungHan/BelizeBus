//
//  Extension_ScheduleView_SetDateLabelDelegate.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
extension ScheduleView: SetDateLabelDelegate{
    func setDateLabel(date: String, day: String, hour: String, minute: String) {
        disappearBlackView()
        guard let outboundTableViewCell = outboundTableViewCell else {
            return
        }
        outboundTableViewCell.subTitleLabel.text = date
        outboundTableViewCell.subTitleLabel.textColor = UIColor.darkOrange.withAlphaComponent(0.6)
        outboundSubtitleLabelText = date
        busStartDay = day
        busStartHour = Int(hour)
        busStartMinute = Int(minute)
    }
    
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
