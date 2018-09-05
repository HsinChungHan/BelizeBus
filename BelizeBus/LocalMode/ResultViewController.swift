//
//  ResultViewController.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/25.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var isTwoStages: Bool?{
        didSet{
          
        }
    }
    
    
    var twoStagesBusInformations: [TwoStagesBusInformation]?{
        didSet{
            
        }
    }
    
    var indexPageInformation: IndexPageInformation?{
        didSet{
            guard
                let time = indexPageInformation?.time,
                let startStation = indexPageInformation?.startStation,
                let endStation = indexPageInformation?.endStation,
                let isTwoStages = isTwoStages
            else {return}
            let transportedStation = indexPageInformation?.transportedStation
//            isTwoStages = ((indexPageInformation?.transportedStation) != nil) ? true : false
            informationView.setupViewValues(isTwoStages: isTwoStages, time: time, startStation: startStation, endStation: endStation, transportedStation: transportedStation)
            
        }
    }
    
    var leftBarButtonItem: UIBarButtonItem?
    let threeStationsScheduleCellID = "ThreeStationsScheduleCellID"
    let busScheduleTableViewCellID = "BusScheduleTableViewCell"
    
    //被使用者選中要展開的cell(要做點擊才展開的tableView)
    var selectedCellIndexPath = IndexPath(row: 0, section: 0)
    var popCellHeight: CGFloat = 266
//    var popCellHeight: CGFloat = 500 //for Ipad
    
    
    
    let informationView: InformationView = {
       let iv = InformationView()
        return iv
    }()
    
    lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNaviStyle()
        registerCell()
        setupTableViewStyle()
        print(UIScreen.main.bounds.width)
    }
}


extension ResultViewController{
    fileprivate func setupViews(){
        view.backgroundColor = UIColor.backgroundRiceColor
        setupInformationView()
        setupTableView()
    }
    
    fileprivate func setupInformationView(){
        view.addSubview(informationView)
        informationView.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 190)
        
    }
    
    fileprivate func setupTableView(){
        view.addSubview(tableView)
        tableView.anchor(top: informationView.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 11, rightPadding: 11, width: 0, height: 0)
    }
    
    fileprivate func setupNaviStyle(){
        navigationItem.title = NaviTitle.ResultTitle.rawValue
        setupDismissButton()
    }
    
    fileprivate func setupDismissButton(){
        leftBarButtonItem = UIBarButtonItem(title: NaviItemLabelText.BackItem.rawValue , style: .plain, target: self, action: #selector(handleBackItem))
        leftBarButtonItem?.setTitleTextAttributes(
            [
                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: DoneBtnStyle.Enable.set.size),
                NSAttributedStringKey.foregroundColor: DoneBtnStyle.Enable.set.color
            ]
            , for: .normal )
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func handleBackItem(){
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func registerCell(){
        tableView.register(ThreeStationsScheduleCell.self, forCellReuseIdentifier: threeStationsScheduleCellID)
    }
    
    public func initValue(schedules: [TwoStagesBusInformation]?, indexPageInformation: IndexPageInformation){
        self.twoStagesBusInformations = schedules
        self.indexPageInformation = indexPageInformation
    }
    
   
}



extension ResultViewController: UITableViewDelegate, UITableViewDataSource{
    func setupTableViewStyle(){
        tableView.backgroundColor = UIColor.backgroundRiceColor
        tableView.separatorStyle = .none
        tableView.separatorColor = .white
        tableView.showsVerticalScrollIndicator = false
        
        //讓沒有row的地方，直接就是底色
        let blankView = UIView(frame: .zero)
        tableView.tableFooterView = blankView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let twoStagesBusInformations = twoStagesBusInformations else {return 0}
        return twoStagesBusInformations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: threeStationsScheduleCellID, for: indexPath) as! ThreeStationsScheduleCell
//        for cell in cell.contentView.subviews{cell.removeFromSuperview()}
//        cell.busesView.removeFromSuperview()
        
        guard let twoStagesBusInformations = twoStagesBusInformations else {return cell}
        let busInformation = twoStagesBusInformations[indexPath.item]
        guard let firstStageInformation = busInformation.firstStageBusInformation else {return cell}
        let secondStageImformation = busInformation.secondStageBusInformation
        cell.setupViewValues(firstStageInformation: firstStageInformation, sencondStageInfornmation: secondStageImformation)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var height: CGFloat = 120
        var height: CGFloat = 120
        guard let isTwoStages = isTwoStages else {
            return height
        }
        if selectedCellIndexPath == indexPath{
            if isTwoStages{
                height = height + popCellHeight
            }else{
                height = height + popCellHeight/2 + 10//ipad版行為+20為上面的公車和下面的公車的padding
            }
        }else{
            height = 120
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == selectedCellIndexPath{
            selectedCellIndexPath = IndexPath()
        }else{
            selectedCellIndexPath = indexPath
        }

        tableView.reloadRows(at: [indexPath], with: .fade)
        tableView.scrollToRow(at: indexPath, at: .top , animated: true)
    }
    
    
}
