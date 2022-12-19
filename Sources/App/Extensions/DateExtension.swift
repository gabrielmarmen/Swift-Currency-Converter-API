//
//  File.swift
//  
//
//  Created by Gabriel Marmen on 2022-11-18.
//

import Foundation

extension Date {
    static var debugTimeStamp: String {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return "[\(String(format: "%02d-%02d-%02d", year, month, day)) - \(date.formattedTime)]"
    }
    
    var formattedTime: String {
        let calendar = Calendar.current
        var components = [Int]()
        var string = ""
        
        components.append(calendar.component(.hour, from: self))
        components.append(calendar.component(.minute, from: self))
        components.append(calendar.component(.second, from: self))
        
        for i in 0..<3   {
            if components[i] < 10 {
                string.append("0")
                string.append(contentsOf: String(components[i]))
            }
            else {
                string.append(contentsOf: String(components[i]))
            }
            if i != 2 {
                string.append(":")
            }
        }
        return string
    }
    
    
    
}

