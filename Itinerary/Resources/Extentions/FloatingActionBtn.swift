//
//  FloatingActionBtn.swift
//  Itinerary
//
//  Created by MAK on 6/15/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

class FloatingActionBtn: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        layer.backgroundColor = Theme.tint?.cgColor
        layer.cornerRadius = frame.height/2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.masksToBounds = false
    }
    

}
