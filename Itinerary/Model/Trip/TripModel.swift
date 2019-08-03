//  TripModel.swift
//  Itinerary
//
//  Created by MAK on 6/14/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import Foundation
import UIKit
struct TripModel{
    var id:UUID
    var title:String
    var image: UIImage?
    var dayModels = [DayModel](){
        didSet{
            dayModels = dayModels.sorted(by: <)
        }
    }
    
    init(title: String, image: UIImage? = nil, dayModels: [DayModel]? = nil) {
        id = UUID()
        self.title = title
        self.image = image
        
        if let dayModels = dayModels{
            self.dayModels = dayModels
        }
    }
}
