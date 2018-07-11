//
//  OutboundSelectionPickerView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/13.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import Foundation
enum DateFormatterConstant: String{
    case wholeDate = "yyyy/MM/dd, EEE, HH:mm"
    case day = "EEE"
    case hour = "HH"
}


protocol SetDateLabelDelegate {
    func setDateLabel(date: String, day: String, hour: String)
}


class OutboundSelectionPickerView: BasicSelectionPickerView {
    var delegate: SetDateLabelDelegate?
    var day: String?
    var hour: String?
    var wholeDate: String?
    
    lazy var datePicker: UIDatePicker = {
       let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.minuteInterval = 60
        dp.date = Date()
        dp.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        return dp
    }()

    
    /*
     yyyy：西元年份，像是 2015、1998。
     yy：西元年份末兩位數，像是 15、95。
     MMMM：月份，像是 December、January。
     MMM：月份簡寫，像是 Oct、Feb。
     MM：以數字代表月份，像是 08、12。
     dd：日期，像是 07、31。
     EEEE：星期幾，像是 Saturday、Monday。
     EEE：星期幾的簡寫，像是 Sun、Wed。
     HH：24 小時制的時。
     hh：12 小時制的時。
     mm：分。
     ss：秒。
     */
    @objc func dateChanged(){
        wholeDate = fetchTime(formatter: DateFormatterConstant.wholeDate.rawValue)
        day = fetchTime(formatter: DateFormatterConstant.day.rawValue)
        hour = fetchTime(formatter: DateFormatterConstant.hour.rawValue)
    }
    
    func fetchTime(formatter: String) -> String? {
        let dateFormatter = DateFormatter()
        switch formatter {
        case DateFormatterConstant.wholeDate.rawValue :
            dateFormatter.dateFormat = DateFormatterConstant.wholeDate.rawValue
        case DateFormatterConstant.day.rawValue:
            dateFormatter.dateFormat = DateFormatterConstant.day.rawValue
        case DateFormatterConstant.hour.rawValue:
            dateFormatter.dateFormat = DateFormatterConstant.hour.rawValue
        default:
            return nil
        }
        return dateFormatter.string(from: datePicker.date)
    }
    
    
    override func setupViews() {
        super.setupViews()
        addViews()
        doneButton.addTarget(self, action: #selector(dismissSelectionPickerView), for: .touchUpInside)
        super.setupLabelTitle(leftText: TitleOfLabel.OutboundDateLabel.rawValue , rightText: TitleOfLabel.OutboundTimeLabel.rawValue)
        wholeDate = fetchTime(formatter: DateFormatterConstant.wholeDate.rawValue)
        day = fetchTime(formatter: DateFormatterConstant.day.rawValue)
        hour = fetchTime(formatter: DateFormatterConstant.hour.rawValue)
    }
    
    @objc func dismissSelectionPickerView(){
        guard let wholeDate = wholeDate, let day = day, let hour = hour else {
            return
        }
        delegate?.setDateLabel(date: wholeDate, day: day, hour: hour)
        
        let transform = CGAffineTransform(translationX: 0, y: ViewConstant.SelectionPickerViewHeight.rawValue)
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            self.layoutIfNeeded()
            self.transform = transform
        }, completion: nil)
    }
    
    func addViews() {
        addSubview(datePicker)
        datePicker.anchor(top: doneButton.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 40, bottomPadding: 0, leftPadding: -40, rightPadding: -40, width: 0, height: 0)
        
        leftLabel.anchor(top: nil, bottom: datePicker.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 100, height: 25)
        leftLabel.centerXAnchor.constraint(equalTo: leftDummyView.centerXAnchor).isActive = true
        
        rightLabel.anchor(top: nil, bottom: datePicker.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 100, height: 25)
        rightLabel.centerXAnchor.constraint(equalTo: rightDummyView.centerXAnchor).isActive = true
    }
    
    
}
