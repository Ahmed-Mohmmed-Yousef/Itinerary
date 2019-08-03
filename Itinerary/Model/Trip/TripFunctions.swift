//
//  TripFunctions.swift
//  Itinerary
//
//  Created by MAK on 6/14/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import Foundation
import UIKit
class TripFunctions{
    static func createTrip(tripModel: TripModel){
        Data.tripModels.append(tripModel)
    }
    
    static func readTrips(completion: @escaping () -> ()){
        DispatchQueue.global(qos: .default).async {
            if Data.tripModels.count == 0{
                Data.tripModels = MockData.createMockTripModelData()
            }
            
        
            DispatchQueue.main.async {
                completion()
            }
        }
        
    }
    
    static func readTrip(by id: UUID, completion: @escaping (TripModel?) -> ()){
        // replace with real data store code
        DispatchQueue.global(qos: .userInitiated).async {
            let trip = Data.tripModels.first(where: {$0.id == id})
            DispatchQueue.main.async {
                completion(trip)
            }
        }
    }
    
    static func updateTrip(index: Int, title: String, image: UIImage? = nil){
        Data.tripModels[index].title = title
        Data.tripModels[index].image = image
    }
    
    static func deleteTrip(index: Int){
        Data.tripModels.remove(at: index)
    }
}
