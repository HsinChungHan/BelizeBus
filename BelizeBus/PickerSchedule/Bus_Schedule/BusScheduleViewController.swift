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
