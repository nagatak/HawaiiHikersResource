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
//    private static var __once: () = {
//            Static.instance = ShareData()
//        }()
//    class var sharedInstance: ShareData {
//        struct Static {
//            static var instance: ShareData?
//            static var token: Int = 0
//        }
//        
//        _ = ShareData.__once
//        
//        return Static.instance!
//    }
    
    static let sharedInstance = ShareData()
    
    var passedCoordinate : CLLocationCoordinate2D!
    
}
