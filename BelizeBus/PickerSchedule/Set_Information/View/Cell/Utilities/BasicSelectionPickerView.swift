//
//  BasicSelectionPickerView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/6/13.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class BasicSelectionPickerView: BasicView {
    let darkGreenView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.classicDarkGreen
        return view
    }()
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let leftDummyView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let rightDummyView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var doneButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(ButtonLabelText.DoneButton.rawValue , for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(UIColor.darkOrange , for: .normal)
        return btn
    }()
  
    override func setupViews() {
        backgroundColor = UIColor.white
        addSubview(darkGreenView)
        addSubview(leftDummyView)
        addSubview(rightDummyView)
        addSubview(doneButton)
        addSubview(leftLabel)
        addSubview(rightLabel)
        darkGreenView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 50)
        leftDummyView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: centerXAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        rightDummyView.anchor(top: topAnchor, bottom: bottomAnchor, left: centerXAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        doneButton.anchor(top: topAnchor, bottom: nil, left: nil, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 20, width: 100, height: 30)
    }

    func setupLabelTitle(leftText: String, rightText: String) {
        leftLabel.text = leftText
        rightLabel.text = rightText
    }

}
