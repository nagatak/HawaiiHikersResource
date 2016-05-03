//
//  ShareData.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 5/1/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import Foundation
import CoreLocation

class ShareData {
    class var sharedInstance: ShareData {
        struct Static {
            static var instance: ShareData?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ShareData()
        }
        
        return Static.instance!
    }
    
    
    var passedCoordinate : CLLocationCoordinate2D!
    
}