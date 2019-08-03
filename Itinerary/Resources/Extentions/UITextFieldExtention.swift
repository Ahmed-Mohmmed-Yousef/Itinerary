//
//  UITextFieldExtention.swift
//  Itinerary
//
//  Created by MAK on 6/20/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit

extension UITextField{
    var hasValue: Bool{
        guard text == "" else{ return true}
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageView.image = UIImage(named: "warning")
        contentMode = .scaleAspectFit
        rightView = imageView
        rightViewMode = .unlessEditing
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        
        return false
    }
}
