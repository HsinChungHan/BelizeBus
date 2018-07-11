//
//  Extension_BusScheduleViewController.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
extension BusScheduleViewController{
    func setupNaviStyle() {
        navigationItem.title = NaviTitle.BusSchedule.rawValue
        navigationController?.navigationBar.barTintColor = UIColor.classicDarkBlack
        let lefttBarButtonItem = UIBarButtonItem(title: NaviItemLabelText.DismissItem.rawValue , style: .plain, target: self, action: #selector(dismissPage))
        lefttBarButtonItem.setTitleTextAttributes(
            [
                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: DoneBtnStyle.Enable.set.size),
                NSAttributedStringKey.foregroundColor: DoneBtnStyle.Enable.set.color
            ]
            , for: .normal )
        navigationItem.leftBarButtonItem = lefttBarButtonItem
    }
    
    @objc func dismissPage(){
        northernSchedules.removeAll()
        westernSchedules.removeAll()
        southernSchedules.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    func registerCell(){
        collectionView.register(BusScheduleCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellId.BusScheduleCollectionViewCellID.rawValue)
    }
    
    func setupViews(){
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 30, rightPadding: 10, width: 0, height: 0)
        view.addSubview(dayLabel)
        dayLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dayLabel.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        dayLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        setupDayLabelText()
        
    }
    
}
