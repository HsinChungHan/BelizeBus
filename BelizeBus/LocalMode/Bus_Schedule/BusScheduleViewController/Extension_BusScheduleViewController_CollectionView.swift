//
//  Extension_BusScheduleViewController_CollectionView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/11.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

extension BusScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !northernSchedules.isEmpty{
            postShown = [Bool](repeating: false, count: northernSchedules.count)
            return northernSchedules.count
        }else if !southernSchedules.isEmpty{
            postShown = [Bool](repeating: false, count: southernSchedules.count)
            return southernSchedules.count
        }else {
            postShown = [Bool](repeating: false, count: westernSchedules.count)
            return westernSchedules.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellId.BusScheduleCollectionViewCellID.rawValue , for: indexPath) as! BusScheduleCollectionViewCell
        cell.setupViews()
        cell.busInformation = busInformation
        if !northernSchedules.isEmpty{
            cell.northernSchedule = northernSchedules[indexPath.item]
        }else if !southernSchedules.isEmpty{
            cell.southernSchedule = southernSchedules[indexPath.item]
        }else {
            cell.westernSchedule = westernSchedules[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if postShown[indexPath.row] {
            return
        }
        postShown[indexPath.row] = true
        let transform = CATransform3DTranslate(CATransform3DIdentity, 500, 0, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut , animations: {
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
        
    }
    
}


extension BusScheduleViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.width/3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
