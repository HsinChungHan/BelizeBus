//
//  OutBoundTableViewCell.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/13.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class OutboundTableViewCell: BasicTableViewCell {

    override func setupViews() {
        super.setupViews()
        titleLabel.text = TitleLabelBasicContent.Outbound.rawValue
        subTitleLabel.text = SubtilteLabelBasicContent.Outbound.rawValue
    }

}
