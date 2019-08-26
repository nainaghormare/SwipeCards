//
//  TimeUtils.swift
//  IotiedNurseApp
//
//  Created by Naina Ghormare on 6/4/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

enum DateFormats{
    static let DD_MMM_YYYY                      = "dd MMM yyyy"
    static let MM_DD_YYYY                       = "MM-dd-YYYY"
    static let YYYY_MM_DD                       = "YYYY-MM-dd"
    static let yyyy_MM_dd_T_HH_mm_ss_SSSZ       = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let HH_mm                            = "HH:mm"
    static let hh_mm_aaa                        = "hh:mm aaa"
}

class TimeUtils: NSObject {
    
    class func dateToEST(date: Date, toFormat: String) -> String? {
        let dateFormatter           = DateFormatter()
        dateFormatter.timeZone      = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat    = toFormat
        let time                    = dateFormatter.string(from: date)
        return time
    }
    
    // Mark- Convert date from string
    class func dateFromString(_ strDate:String?, with format:String) -> Date? {
        guard let st = strDate else {
            return Date()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let result = dateFormatter.date(from: st)
        return result
    }
    
    // Mark- Convert string form date
    class func stringFromDate(_ date:Date?, with format:String) -> String {
        guard let dt = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dt) 
    }
    
    // Mark-Convert date from Formates
    class func convertdateFormater(_ strDate:String?,fromFormat:String, toFormat:String) -> String{
        guard let st = strDate else {
            return ""
        }
        let outFormatter = DateFormatter()
        outFormatter.dateFormat = fromFormat
        if let date = outFormatter.date(from: st) {
            return self.stringFromDate(date, with: toFormat)
        }
        return ""
    }
    
    // Mark- Get time diff between dates
    class func timeIntervalBetweenDates(startDate strStartDate:String?, enddate strEndDate:String?, with format:String)->TimeInterval {
        let sDate = self.dateFromString(strStartDate, with: format)
        let edate = self.dateFromString(strEndDate, with: format)
        return edate!.timeIntervalSince(sDate!)
    }
    
    class func convertMilisecondToDate(strMiliseconds : String?, toFormat : String) -> String{
        if let strMiliseconds = strMiliseconds,let time = Double(strMiliseconds) {
            let date = Date(timeIntervalSince1970: TimeInterval(time/1000.0))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    class func localToUTC(date:String, format : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: dt ?? Date()) 
    }
    
    class func UTCToLocal(date:String, format : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: dt ?? Date()) 
    }
    
    class func dateStringToUTC(date: Date, toFormat:String) -> String? {
        let dateFormatter           = DateFormatter()
        dateFormatter.timeZone      = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat    = toFormat
        let time                    = dateFormatter.string(from: date)
        return time
    }
    
    class func UTCDateToLocalDate(date:Date, format : String) -> Date {
        let dateString = self.stringFromDate(date, with: format)
        let localDateString = self.UTCToLocal(date: dateString, format: format)
        return self.dateFromString(localDateString, with: format) ?? Date()
    }
    
    //Get difference betweeen time
    class func diffBetweenTime(from: Date, to: Date) -> String {
        var calendar                = Calendar(identifier: .hebrew)
        calendar.timeZone           = TimeZone(abbreviation: "EST") ?? TimeZone.current
        let timeComponents          = calendar.dateComponents([.day, .hour, .minute, .second], from: from)
        let nowComponents           = calendar.dateComponents([.day, .hour, .minute, .second], from: to)
        let diff                     = calendar.dateComponents([.hour, .minute, .second], from: timeComponents, to: nowComponents)
        let formatDiff                     = String(format: "%02d:%02d:%2d", diff.hour ?? "", diff.minute ?? "", diff.second ?? "")
        return formatDiff
    }
}

extension Date {
    
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    var startOfMonth:Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    var endOfMonth:Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
    }
    
    var startOfQuarter: Date {
        var components              = Calendar.current.dateComponents([.month, .year], from: self)
        let newMonth                : Int
        switch components.month! {
        case 1,2,3: newMonth        = 1
        case 4,5,6: newMonth        = 4
        case 7,8,9: newMonth        = 7
        case 10,11,12: newMonth     = 10
        default: newMonth           = 1
        }
        components.month            = newMonth
        return Calendar.current.date(from: components)!
    }
    
    var endOfQuarter: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 3, day: -1), to: startOfQuarter)!
    }
    
    var startOfYear: Date {
        var components = Calendar.current.dateComponents([.month, .year], from: self)
        components.month = 1
        return Calendar.current.date(from: components)!
    }
    
    var endOfYear: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 12, day: -1), to: startOfYear)!
    }
    
    var unixTimeStamp:String {
        return "\(self.timeIntervalSince1970 * 1000)"
    }
    
    func toString(with format : String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        return dateString
    }
    
    func isBetween(from startDate: Date,to endDate: Date) -> Bool {
        let result = (min(startDate, endDate) ... max(startDate, endDate)).contains(self)
        return result
    }
    
    func isBetweenDates(beginDate: Date, endDate: Date) -> Bool {
        if self.compare(beginDate) == .orderedAscending {
            return false
        }
        if self.compare(endDate) == .orderedDescending {
            return false
        }
        
        return true
    }
    
}

extension Int {
//    private var milliseconds: Int {
//        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
//    }
//    private var seconds: Int {
//        return Int(self) % 60
//    }
//    private var minutes: Int {
//        return (Int(self) / 60 ) % 60
//    }
//    private var hours: Int {
//        return Int(self) / 3600
//    }
//    var stringTime: String {
//        return "\(hours):\(minutes):\(seconds)"
//    }
    
    func secondsToHoursMinutesSeconds() -> (h: Int, m : Int, s : Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
    
}

extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        
    }
}
