//
//  DateUtility.swift
//  SportsApp
//
//  Created by Macos on 20/05/2025.
//

import Foundation

struct DateManger{
    
    static func getCurrentDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: Date())
        return formattedDate
    }
    
    static func getNextWeekDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
 
        if let futureDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) {
            let formattedDate = dateFormatter.string(from: futureDate)
            return formattedDate
        }
 
        return ""
    }
    
    static func getPreviousWeekDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
 
        if let futureDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) {
            let formattedDate = dateFormatter.string(from: futureDate)
            return formattedDate
        }
 
        return ""
    }
}
