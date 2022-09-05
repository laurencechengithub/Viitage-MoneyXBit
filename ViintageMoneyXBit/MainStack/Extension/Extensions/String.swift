//
//  String.swift
//  ViitageEX
//
//  Created by LaurenceMBP2 on 2022/7/4.
//

import Foundation

extension String {
    
    func toDouble() -> Double {
        let string = self as NSString
        let convertedToDouble = string.doubleValue
        return convertedToDouble
    }
    
    func toDoubleAndRound(to decimal:Int) -> String {
        let string = self as NSString
        let convertedToDouble = string.doubleValue
        return convertedToDouble.asDoubleString(roundTo: decimal)
    }
    
    func toFormateDate() -> Date? {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM d, yyyy"
        dateFormater.locale     = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone   = .current
        
        return dateFormater.date(from: self)
    }
    
    
    //remove html from string
    var removingHTMLOccurances:String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    
    //Get char from string using index
    func getCharAtIndex(_ index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
 
    func toDateFormattUsedAtIntryApi() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm"
        return dateFormatter.date(from: self)
    }
    
    
}


//Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
//09/12/2018                        --> MM/dd/yyyy
//09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
//Sep 12, 2:11 PM                   --> MMM d, h:mm a
//September 2018                    --> MMMM yyyy
//Sep 12, 2018                      --> MMM d, yyyy
//Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
//2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
//12.09.18                          --> dd.MM.yy
//10:41:02.112                      --> HH:mm:ss.SSS
