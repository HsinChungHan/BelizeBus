//
//  Extension_ScheduleView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

extension ScheduleView{
    func registerCell(){
        tableView.register(ItineraryTableViewCell.self, forCellReuseIdentifier: CellId.ItineraryID.rawValue)
        tableView.register(BusRouteTableViewCell.self, forCellReuseIdentifier: CellId.BusRouteID.rawValue)
        tableView.register(OutboundTableViewCell.self, forCellReuseIdentifier: CellId.OutboundID.rawValue)
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.fullAnchor(superView: self)
        tableView.isScrollEnabled = false
    }
    
    func setupTableViewStyle(){
        tableView.backgroundColor = UIColor.classicDarkBlack
        tableView.separatorColor = .white
        let blankView = UIView(frame: .zero)
        tableView.tableFooterView = blankView
        
    }
    
    
    func setupSelectionPickerView() {
        addSubview(itinerarySelectionPickerView)
        addSubview(outboundSelectionPickerView)
        itinerarySelectionPickerView.anchor(top: bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: ViewConstant.SelectionPickerViewHeight.rawValue)
        outboundSelectionPickerView.anchor(top: bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: ViewConstant.SelectionPickerViewHeight.rawValue)
        
    }
    
    func setupValues() {
        outboundSubtitleLabelText = SubtilteLabelBasicContent.Outbound.rawValue
        itinerarySubtitleLabelText = SubtilteLabelBasicContent.Itinerary.rawValue
    }
    
    func setupBlackView() {
        self.addSubview(blackView)
        blackView.fullAnchor(superView: self)
    }
    
    func disappearBlackView(){
        UIView.animate(withDuration: 1.5, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[weak self] in
            self?.blackView.alpha = 0
        })
    }
}
