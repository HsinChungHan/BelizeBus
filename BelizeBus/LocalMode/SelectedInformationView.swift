//
//  SelectedInformationView.swift
//  BelizeBus
//
//  Created by 辛忠翰 on 2018/7/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class SelectedInformationView: BasicView {
    let textBrownColor = UIColor.rgb(red: 132, green: 94, blue: 85)
    var imgName: String?{
        didSet{
            guard let imgName = imgName else {return}
            iconImgView.image = UIImage(named: imgName)
        }
    }
    
    var title: String?{
        didSet{
            guard let title = title else {return}
            titleLabel.text = title
        }
    }
    
    let iconImgView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = textBrownColor
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .clear
        addSubview(iconImgView)
        iconImgView.anchor(top: nil, bottom: nil, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 18, height: 25)
        iconImgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: iconImgView.centerYAnchor).isActive = true
        titleLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: iconImgView.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 0, height: 0)
    }
    

}
