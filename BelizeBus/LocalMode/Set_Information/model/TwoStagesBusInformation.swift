//
//  TwoStagesBusInformation.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation

struct TwoStagesBusInformation {
    let firstStageBusInformation: OneStageBusInformation?, secondStageBusInformation: OneStageBusInformation?
    init(firstStageBusInformation: OneStageBusInformation?, secondStageBusInformation: OneStageBusInformation?) {
        self.firstStageBusInformation = firstStageBusInformation
        self.secondStageBusInformation = secondStageBusInformation
    }
}
