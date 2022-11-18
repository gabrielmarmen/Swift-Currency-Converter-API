//
//  File.swift
//  
//
//  Created by Gabriel Marmen on 2022-11-18.
//

import Foundation

extension Date {
    static var debugTimeStamp: String {
        let date = Date.now
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        return "[\(year)-\(month)-\(day) - \(hour):\(minutes):\(seconds)]"
    }
}
