//
//  PinInfo.swift
//  HawaiiHikersResource
//
//  Created by Ray Manzano on 12/3/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import MapKit
import UIKit

class PinInfo: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, subtitle: String) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
    }
}