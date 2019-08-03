//
//  DayModel.swift
//  Itinerary
//
//  Created by MAK on 6/18/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import Foundation

struct DayModel {
    var id: String!
    var title = Date()
    var subTitle = ""
    var activityModels = [ActivityModel]()
    
    init(title: Date, subTitle: String, data: [ActivityModel]?) {
        id = UUID().uuidString
        self.title = title
        self.subTitle = subTitle
        
        if let data = data{
            self.activityModels = data
        }
    }
}

extension DayModel: Comparable{
    static func < (lhs: DayModel, rhs: DayModel) -> Bool {
        return lhs.title < rhs.title
    }
    
    static func == (lhs: DayModel, rhs: DayModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
