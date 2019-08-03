//
//  DayFunction.swift
//  Itinerary
//
//  Created by MAK on 6/21/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import Foundation

class DayFunctions{
    static func creatDays(tripIndex: Int, dayModel: DayModel){
        // Replace with real data store
        
        Data.tripModels[tripIndex].dayModels.append(dayModel)
    }
}
