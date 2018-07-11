//
//  Extension_ScheduleView_SetItineraryLabelDelegate.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension ScheduleView: SetItineraryLabelDelegate{
    func setItineraryLabel(start: String, end: String) {
        disappearBlackView()
        guard let itineraryTableViewCell = itineraryTableViewCell else {return}
        let startToEnd = "\(start) -> \(end)"
        itineraryTableViewCell.subTitleLabel.text = startToEnd
        itineraryTableViewCell.subTitleLabel.textColor = UIColor.darkOrange.withAlphaComponent(0.6)
        itinerarySubtitleLabelText = startToEnd
        busStartStation = start
        busEndStation = end
    }
}
