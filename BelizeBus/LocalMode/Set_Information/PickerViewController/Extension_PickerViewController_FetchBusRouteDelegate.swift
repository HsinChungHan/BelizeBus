//
//  Extension_PickerViewController_FetchBusRouteDelegate.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

extension PickerViewController: FetchBusRouteDelegate{
    func fetchBusRoute(busRoute: String) {
        scheduleView.itineraryTableViewCell?.subTitleLabel.text = SubtilteLabelBasicContent.Itinerary.rawValue
        scheduleView.itineraryTableViewCell?.subTitleLabel.textColor = UIColor.classicBrown
        scheduleView.itineraryTableViewCell?.subTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        doneButtonItemDisabled()
    }
}
