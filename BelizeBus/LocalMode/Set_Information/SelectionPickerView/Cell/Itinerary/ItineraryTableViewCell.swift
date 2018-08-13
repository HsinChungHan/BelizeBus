//
//  ItineraryTableViewCell.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ItineraryTableViewCell: BasicTableViewCell {
    override func setupViews() {
        super.setupViews()
        titleLabel.text = TitleLabelBasicContent.Itinerary.rawValue
        subTitleLabel.text = SubtilteLabelBasicContent.Itinerary.rawValue
    }
}
