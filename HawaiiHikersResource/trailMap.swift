//
//  trailMap.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 3/29/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import Foundation
import MapKit

//class trail {
//    var boundary: [CLLocationCoordinate2D]
//    var boundaryPointsCount: NSInteger
//    
//    var midCoordinate: CLLocationCoordinate2D
//    var overlayTrailMap: CLLocationCoordinate2D
//    var overlayCurrentProgress: CLLocationCoordinate2D
//    var overlayOtherTrails: CLLocationCoordinate2D
//    
//    var overlayBoundingMapRect: MKMapRect
//    
//    var name: String?
//    
//    init(filename: String) {
//        let filePath = NSBundle.mainBundle().pathForResource(filename, ofType: "plist")
//        let properties = NSDictionary(contentsOfFile: filePath!)
//        
//        let midPoint = CGPointFromString(properties!["midCoord"] as! String)
//        midCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(midPoint.x), CLLocationDegrees(midPoint.y))
//        
//        let trailPoint = CGPointFromString(properties!["overlayTrialCoord"] as! String)
//        overlayTrailMap = CLLocationCoordinate2DMake(CLLocationDegrees(trailPoint.x),
//                                                              CLLocationDegrees(trailPoint.y))
//        
//        let currentProgressPoint = CGPointFromString(properties!["overlayCurrentProgressCoord"] as! String)
//        overlayCurrentProgress = CLLocationCoordinate2DMake(CLLocationDegrees(currentProgressPoint.x),
//                                                               CLLocationDegrees(currentProgressPoint.y))
//        
//        let otherTrailsPoint = CGPointFromString(properties!["overlayOtherTrailsCoord"] as! String)
//        overlayOtherTrails = CLLocationCoordinate2DMake(CLLocationDegrees(otherTrailsPoint.x),
//                                                                 CLLocationDegrees(otherTrailsPoint.y))
//        
//        let boundaryPoints = properties!["boundary"] as! NSArray
//        
//        boundaryPointsCount = boundaryPoints.count
//        
//        boundary = []
//        
//        for i in 0...boundaryPointsCount-1 {
//            let p = CGPointFromString(boundaryPoints[i] as! String)
//            boundary += [CLLocationCoordinate2DMake(CLLocationDegrees(p.x), CLLocationDegrees(p.y))]
//        }
//    }
//}
