//
//  DateExtention.swift
//  Itinerary
//
//  Created by MAK on 6/21/19.
//  Copyright © 2019 MAK. All rights reserved.
//

import Foundation

extension Date{
    func add(days: Int) -> Date{
        return Calendar.current.date(byAdding: .day, value: days, to: Date())!
    }
    
    func mediumDate() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
