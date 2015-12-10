//
//  PinInfo.swift
//  HawaiiHikersResource
//
//  Created by Ray Manzano on 12/3/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import MapKit
import UIKit
import Contacts

class PinInfo: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, subtitle: String) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
    }
    
    // Annotation callout info button opens this mapItem in Maps app
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [String(CNPostalAddressStreetKey): subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    func pinLoc() -> CLLocationCoordinate2D
    {
        let pin = coordinate
        
        return pin
    }
}