//
//  s.swift
//  Itinerary
//
//  Created by MAK on 6/15/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

extension UIView {

    func addShadowAndRoundedCorner(){
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 10
    }

}
