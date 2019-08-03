//
//  UIButtonExtention.swift
//  Itinerary
//
//  Created by MAK on 6/15/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

extension UIButton {

    func createFloatingActionBtn(){
        backgroundColor = Theme.tint
        layer.cornerRadius = frame.height/2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }

}
