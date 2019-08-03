//
//  UIViewControllerExtention.swift
//  Itinerary
//
//  Created by MAK on 6/20/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import UIKit


extension UIViewController{
    static func getInstance() -> UIViewController {
    
        /**
         just return view controller on storyboard
         */
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
}
