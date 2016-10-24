//
//  NSAttributedString+Additions.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/23/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import UIKit

extension String {
    
    func attributedString(fontSize: CGFloat, color: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        let attributes = [NSForegroundColorAttributeName: color, NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)]
        attributedString.addAttributes(attributes, range: NSMakeRange(0, self.characters.count))
        
        return attributedString
    }
    
    
    
}
