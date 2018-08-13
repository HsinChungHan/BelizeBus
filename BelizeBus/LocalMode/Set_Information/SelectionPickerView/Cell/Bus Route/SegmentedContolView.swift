//
//  SegmenteContolView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/13.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
protocol ChangeBusRouteProtocol {
    func changeBusRoute(currentValue: String)
}



class SegmentedContolView: BasicView {
    var delegate: ChangeBusRouteProtocol?
    var currentValue: String?{
        didSet{
            guard let currentValue = currentValue else {
                return
            }
            delegate?.changeBusRoute(currentValue: currentValue)
        }
       
    }
    
    lazy var segmentedControl: UISegmentedControl = {
       let sc = UISegmentedControl()
        sc.insertSegment(withTitle: JSONDirectionContent.Northern.rawValue, at: 0, animated: true)
        sc.insertSegment(withTitle: JSONDirectionContent.Southern.rawValue, at: 1, animated: true)
        sc.insertSegment(withTitle: JSONDirectionContent.Western.rawValue, at: 2, animated: true)
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .clear
        sc.tintColor = .clear
        sc.setTitleTextAttributes([
            NSAttributedStringKey.font :UIFont.boldSystemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.classicBrown
            ], for: .normal)
        sc.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor: UIColor.darkOrange.withAlphaComponent(0.6)
            ], for: .selected)
        sc.addTarget(self, action: #selector(segmentedContolValueChanged), for: .valueChanged)
        
        sc.layer.borderWidth = 1.0
        sc.layer.borderColor = UIColor.classicBrown.cgColor
        sc.layer.cornerRadius = 3.0
        sc.clipsToBounds = true
        
        currentValue = sc.titleForSegment(at: sc.selectedSegmentIndex)
        return sc
    }()
    
    @objc func segmentedContolValueChanged(){
        currentValue = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
        }
    }
    
    let buttonBar: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.darkOrange
        view.layer.cornerRadius = 3.0
        view.clipsToBounds = true
        view.alpha = 0.6
        return view
    }()
    
    
    fileprivate func setupSegmentedControlView() {
        addSubview(segmentedControl)
        addSubview(buttonBar)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        // Constrain the segmented control to the top of the container view
        segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        // Constrain the segmented control width to be equal to the container view width
        segmentedControl.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        segmentedControl.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        // Constrain the height of the segmented control to an arbitrarily chosen value
        segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        // Constrain the top of the button bar to the bottom of the segmented control
        buttonBar.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 6).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)).isActive = true
    }
    
    override func setupViews() {
        setupSegmentedControlView()
        
    }

}
