//
//  CLController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 12/9/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import Foundation
import CoreLocation

class CLController : NSObject, CLLocationManagerDelegate {
    
    // Declaration of variables
    var locationManager:CLLocationManager = CLLocationManager()
    
    // Initialize the locationManager
    override init() {
        super.init()
        self.locationManager.delegate = self
        // Request authorization for location services
        self.locationManager.requestAlwaysAuthorization()
        // Must move at least 5000 meters or 5km for update
        self.locationManager.distanceFilter = 5000
        // Accuracy set to 1 km
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        
    }
    // Checks if user has authorized use of location services
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        print("didChangeAuthorizationStatus")
        
        switch status {
        case .NotDetermined:
            print(".NotDetermined")
            break
            
        case .Authorized:
            print(".Authorized")
            self.locationManager.startUpdatingLocation()
            break
            
        case .Denied:
            print(".Denied")
            break
            
        default:
            print("Unhandled authorization status")
            break
        }
    }
    
    // Reverse geocoding function
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last as CLLocation!
        
        //Use for debugging prints lat and longitue to output
        //print("didUpdateLocations:  \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        
        // Mark: Reverse Geocoding
        let geocoder = CLGeocoder()
        // Func returns city, state, country for weather api
        // Reverse Geocoding will use gps location to lookup city, state
        // MUST have error case as geocoding requests are rate limited and may be denied (see documentation)
        // Ken
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, e) -> Void in
            if let error = e {
                print("Error:  \(e!.localizedDescription)")
            } else {
                let placemark = placemarks!.last
                
                let userInfo = [
                    "city":     placemark!.locality ?? " ",
                    "state":    placemark!.administrativeArea ?? " ",
                    "country":  placemark!.country ?? " "
                    ] as! [NSString: NSString!]
                
                
                
                //Use for debugging
                //print("Location:  \(userInfo)")
                
                //Takes location from user info to look up weather data, alerts the observer
                NSNotificationCenter.defaultCenter().postNotificationName("LOCATION_AVAILABLE", object: nil, userInfo: userInfo)
            }
            
        })
    }
}