//
//  Utility.swift
//  Dots
//
//  Created by Kouno, Masayuki on 8/2/14.
//  Copyright (c) 2014 Kouno, Masayuki. All rights reserved.
//

import Foundation

class Utility {
    
    class func dateFromStringFormat(format: String, datetime: String) -> NSDate {
        let inputDateFormatter = NSDateFormatter()
        inputDateFormatter.timeZone = NSTimeZone(abbreviation: "JST")
        inputDateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        inputDateFormatter.dateFormat = format
        let date = inputDateFormatter.dateFromString(datetime)
        return date!
    }
    
    class func stringFromDate(format: String, date: NSDate) -> String {
        let inputDateFormatter = NSDateFormatter()
        inputDateFormatter.timeZone = NSTimeZone(abbreviation: "JST")
        inputDateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        inputDateFormatter.dateFormat = format
        let str = inputDateFormatter.stringFromDate(date)
        return str
    }
    
}