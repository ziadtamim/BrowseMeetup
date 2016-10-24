//
//  DateFormatter+Additions.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/24/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    class func dateWithNoTimeFromTimeInterval(_ timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
}
