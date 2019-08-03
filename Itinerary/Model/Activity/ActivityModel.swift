//
//  ActivityModel.swift
//  Itinerary
//
//  Created by MAK on 6/18/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import Foundation
import UIKit

struct ActivityModel {
    var id: String!
    var title = ""
    var subTitle = ""
    var activityType : ActivityType
    var photo: UIImage?
    
    init(title: String, subTitle: String, activityType: ActivityType, photo: UIImage? = nil) {
        id = UUID().uuidString
        self.title = title
        self.subTitle = subTitle
        self.activityType = activityType
        self.photo = photo
    }
}

extension ActivityModel: Equatable{
    
    static func == (lhs: ActivityModel, rhs: ActivityModel) -> Bool{
        return lhs.id == rhs.id
    }
}
