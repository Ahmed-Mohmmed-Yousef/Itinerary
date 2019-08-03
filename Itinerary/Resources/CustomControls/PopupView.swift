//
//  PopupView.swift
//  Itinerary
//
//  Created by MAK on 6/15/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

class PopupView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 10
        backgroundColor = Theme.background
    }
    

}
