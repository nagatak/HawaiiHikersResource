//
//  CustomTrailMapViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 4/3/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import MapKit

class CustomTrailMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var customMapView: MKMapView!
    
    @IBAction func startMappingTrail(sender: AnyObject) {
        
        print("Start button pressed")
    }
    
    @IBAction func stopMappingTrail(sender: AnyObject) {
        print("Stop button pressed")    }
    
    @IBAction func saveTrail(sender: AnyObject) {
        print("Save button pressed")    }

}
