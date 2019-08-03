//
//  MockData.swift
//  Itinerary
//
//  Created by MAK on 6/18/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import Foundation

class MockData{
    static func createMockTripModelData() -> [TripModel]{
        var mockTrips = [TripModel]()
        mockTrips.append(TripModel(title: "Trip to Bali", image: #imageLiteral(resourceName: "img4"),dayModels: createMockDayModelData()))
        mockTrips.append(TripModel(title: "Trip to Eygpt", image: #imageLiteral(resourceName: "img8"),dayModels: createMockDayModelData()))
         mockTrips.append(TripModel(title: "Trip to Abo Simpl", image: #imageLiteral(resourceName: "img7"),dayModels: createMockDayModelData()))
        return mockTrips
    }
    
    static func createMockDayModelData() -> [DayModel]{
        var dayModels = [DayModel]()
        
        dayModels.append(DayModel(title: Date(), subTitle: "Departure", data: createMockActivityModelData(sectionTitle: "April 18")))
        dayModels.append(DayModel(title: Date().add(days: 1), subTitle: "Exploring", data: createMockActivityModelData(sectionTitle: "April 18")))
        dayModels.append(DayModel(title: Date().add(days: 2), subTitle: "Scuba Diving", data: createMockActivityModelData(sectionTitle: "April 20")))
        dayModels.append(DayModel(title: Date().add(days: 3), subTitle: "Volunteering", data: createMockActivityModelData(sectionTitle: "April 21")))
        dayModels.append(DayModel(title: Date().add(days: 4), subTitle: "Time to go back home", data: createMockActivityModelData(sectionTitle: "April 22")))
        return dayModels
    }
    
    static func createMockActivityModelData(sectionTitle: String) -> [ActivityModel]{
        return [ActivityModel(title: sectionTitle, subTitle: sectionTitle, activityType: .auto),
        ActivityModel(title: sectionTitle, subTitle: sectionTitle, activityType: .auto),
        ActivityModel(title: sectionTitle, subTitle: sectionTitle, activityType: .auto)]
    }
}
