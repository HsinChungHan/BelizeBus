//
//  BusScheduleViewController.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/15.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class BusScheduleViewController: UIViewController {
//    var postShown = [Bool](repeating: false, count: 10)
    var postShown = [Bool]()
    var busInformation: BusInformation?{
        didSet{
            guard let day = busInformation?.day else {
                return
            }
            dayLabel.text = "\(day) June"
        }
    }
    var northernSchedules = [NorthernBusSchedule]()
    var westernSchedules = [WesternBusSchedule]()
    var southernSchedules = [SouthernBusSchedule]()
    
    lazy var dayLabel: UILabel = {
       let label = UILabel()
        label.text = "Mon June"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupDayLabelText(){
        guard let text = dayLabel.text else {
            return
        }
        
        let attributedText = NSMutableAttributedString(string: text, attributes:[
            NSAttributedStringKey.font : UIFont(name: ".PingFangTC-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16),
            NSAttributedStringKey.foregroundColor : UIColor.lightseagreen,
        ])
        dayLabel.attributedText = attributedText
    }
    
    lazy var collectionView: UICollectionView = {
       let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
       let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        cv.backgroundColor = UIColor.clear
        cv.allowsSelection = false
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.classicDarkBlack
        setupNaviStyle()
        setupViews()
        registerCell()
    }
    

}








