//
//  Date.swift
//  TaskItProject
//
//  Created by Adriel Carsete on 5/28/15.
//  Copyright (c) 2015 Adriel Carsete. All rights reserved.
//

import Foundation

class Date {
    
    class func from (#year:Int, month:Int, day:Int) -> NSDate {
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
       // var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
        var gregorianCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        
        
        var date = gregorianCalendar?.dateFromComponents(components)
        
        
        return date!
    }
    
    class func toString(#date:NSDate) -> String {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd" //english format
        let dateString = dateStringFormatter.stringFromDate(date)
        
        return dateString
    }
    
}