//
//  ActivityFunctions.swift
//  Itinerary
//
//  Created by MAK on 6/22/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import Foundation

class ActivityFunctions{
    
    static func creatActivity(at tripIndex: Int,for dayIndex: Int, using activityModel: ActivityModel){
        // Replace with real data store
        Data.tripModels[tripIndex].dayModels[dayIndex].activityModels.append(activityModel)
    }
    
    static func deleteActivity(at tripIndex: Int,for dayIndex: Int, using activityModel: ActivityModel){
        // Replace with real data store
        
        var dayModel = Data.tripModels[tripIndex].dayModels[dayIndex]
        
        if let index = dayModel.activityModels.firstIndex(of: activityModel){
            dayModel.activityModels.remove(at: index)
        }
        
    }
    
    static func updateActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, using activityModel: ActivityModel){
        
        if oldDayIndex != newDayIndex{
            // move activity to different day
            let lastIndex = Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels.count
            reorderActivity(at: tripIndex, oldDayIndex: oldDayIndex, newDayIndex: newDayIndex, newActivityIndex: lastIndex, activityModel: activityModel)
            
            
        } else{
            let dayModel = Data.tripModels[tripIndex].dayModels[oldDayIndex]
            let activityIndex = (dayModel.activityModels.firstIndex(of: activityModel))!
            Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels[activityIndex] = activityModel
        }
    }
    
    static func reorderActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, newActivityIndex: Int, activityModel: ActivityModel){
        
        // 1. ewmove activity from old location
        let dayModel = Data.tripModels[tripIndex].dayModels[oldDayIndex]
        let oldActivityIndex = (dayModel.activityModels.firstIndex(of: activityModel))!
        Data.tripModels[tripIndex].dayModels[oldDayIndex].activityModels.remove(at: oldActivityIndex)
        
        // 2. insert activity into new location
        Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels.insert(activityModel, at: newActivityIndex)
        
    }
}
