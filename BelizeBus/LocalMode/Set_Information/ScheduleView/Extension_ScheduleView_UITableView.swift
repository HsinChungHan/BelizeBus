//
//  Extension_ScheduleView_UITableView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
extension ScheduleView: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellId.BusRouteID.rawValue , for: indexPath) as! BusRouteTableViewCell
            busRouteTableViewCell = cell
            cell.segmentedContolView.delegate = self
            cell.setupViews()
            cell.selectionStyle = .none
            busRoute = cell.segmentedContolView.currentValue ?? "North"
            return cell
            
        }else if indexPath.item == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellId.ItineraryID.rawValue , for: indexPath) as! ItineraryTableViewCell
            itineraryTableViewCell = cell
            cell.setupViews()
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellId.OutboundID.rawValue , for: indexPath) as! OutboundTableViewCell
            outboundTableViewCell = cell
            cell.setupViews()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        decideDoneBtnDelegate?.disebleDoneState()
        let transform = CGAffineTransform(translationX: 0, y: -ViewConstant.SelectionPickerViewHeight.rawValue)
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
            if indexPath.item == 1{
                self.blackView.alpha = 1.0
                self.itinerarySelectionPickerView.transform = transform
                self.itinerarySelectionPickerView.setItineraryLabelDelegate = self
            }else if indexPath.item == 2{
                self.blackView.alpha = 1.0
                self.outboundSelectionPickerView.transform = transform
                self.outboundSelectionPickerView.delegate = self
            }
            
        }, completion: nil)
    }
    
    
}
