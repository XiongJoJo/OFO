//
//  TimeHelper.swift
//  OFO
//
//  Created by JoJo on 2017/6/12.
//  Copyright © 2017年 JoJo. All rights reserved.
//

import Foundation

struct TimeHelper {
    
}

extension TimeHelper {
    // UIColor(red: 247/255, green: 215/255, blue: 80/255, alpha: 1)
    static func getFormatTimeWithTimeInterval(timeInterval: Double) -> String{
    
    let hour = Int(timeInterval /  (60*60))
    let sec = Int(timeInterval.truncatingRemainder(dividingBy: 60))
    let min = Int(timeInterval / 60)
    
    return String(format: "%02zd:%02zd:%02zd", arguments: [hour,min,sec])
    }
    
    static func getTimeIntervalWithFormatTime(format: String) -> Double{
        let minAsec = format.components(separatedBy: ":")
        let min = minAsec.first
        let sec = minAsec.last
        
        return Double(min!)! * 60 + Double(sec!)!
    }

}
