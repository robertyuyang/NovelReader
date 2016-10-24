//
//  Config.swift
//  MyReader
//
//  Created by mac on 10/21/16.
//  Copyright © 2016 BEIJING. All rights reserved.
//

import UIKit

@objc class Config: NSObject{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    public var font = UIFont.systemFont(ofSize: 20)
    public var foregroundColor = UIColor.blue
   
    public let kPadding : CGFloat = 30.0
   
    static let sharedObject = Config()
        
    public func getPageTextRect(frame : CGRect) -> CGRect {
        return CGRect(x: kPadding, y: kPadding,
                      width:frame.size.width - 2 * kPadding,
                      height: frame.size.height - 2 * kPadding);
    }
   /*
    private func convertNSString(str : String) -> NSString* {
        return NSString(str.
    }
    
    public func getTextAttribute() ->NSDictionary {
        let attrDict : [NSString: AnyObject] = [
            NSForegroundColorAttributeName: self.foregroundColor,
            NSFontAttributeName: self.font]
        return
    }*/

}
