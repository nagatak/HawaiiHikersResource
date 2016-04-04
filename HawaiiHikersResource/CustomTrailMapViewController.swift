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
    
    var manager:CLLocationManager!
    var trailcoordinates: [CLLocationCoordinate2D] = []
    
    @IBOutlet weak var customMapView: MKMapView!
    
    @IBAction func startMappingTrail(sender: AnyObject) {
        manager.startUpdatingLocation()
    }
    
    @IBAction func stopMappingTrail(sender: AnyObject) {
        manager.stopUpdatingLocation()
    }
    
    @IBAction func saveTrail(sender: AnyObject) {
        
        let saveAlert = UIAlertController(title: "Save Trail Map", message: "Enter the trail's name.", preferredStyle: .Alert)
        
        saveAlert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Some default text."
        })
        
        saveAlert.addAction(UIAlertAction(title: "Save", style: .Default , handler: { (action) -> Void in
            let textField = saveAlert.textFields![0] as UITextField
            print("Text field: \(textField.text)")
        }))
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .Destructive, handler: nil))
        
        self.presentViewController(saveAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: initializing the location manager
        manager = CLLocationManager()
        manager.delegate = self
        // Set accuracy to 10 meters. Change to AccuracyBest if more accuracy is needed.
        manager.desiredAccuracy = kCLLocationAccuracyBest
        // Always request aurorization from user for location services
        manager.requestWhenInUseAuthorization()
        // Starts updating the current gps position
        
        customMapView.delegate = self
        // Sets default map type to hybrid
        customMapView.mapType = MKMapType.Satellite
        // Shows user location on map
        customMapView.showsUserLocation = true
        
        
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //trailcoordinates.append(locations[0] as CLLocation)

        trailcoordinates.append(manager.location!.coordinate)
        
        //Sets span og viewable area
        let spanX = 0.002
        let spanY = 0.002
        //Declare new reigon
        let newRegion = MKCoordinateRegion(center: customMapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        //Initialze values
        customMapView.setRegion(newRegion, animated: true)
        
        if (trailcoordinates.count > 1){
            var sourceIndex = trailcoordinates.count - 1
            var destinationIndex = trailcoordinates.count - 2

            let s = trailcoordinates[sourceIndex]
            let d = trailcoordinates[destinationIndex]
            var a = [s, d]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            customMapView.addOverlay(polyline)
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            // Change stroke color
            polylineRenderer.strokeColor = UIColor(red: 0.0, green: 0.0, blue: 1, alpha: 1)
            // Change number to alter line width
            polylineRenderer.lineWidth = 7
            return polylineRenderer
        }
        return MKPolylineRenderer()
   }
}
