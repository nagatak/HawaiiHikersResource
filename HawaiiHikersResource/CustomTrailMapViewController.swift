//
//  CustomTrailMapViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 4/3/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
///

import UIKit
import Foundation
import CoreData
import MapKit

class CustomTrailMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var manager:CLLocationManager!
    var trailcoordinates: [CLLocation] = []
    var customTrail = [NSManagedObject]()
    
    @IBOutlet weak var customMapView: MKMapView!
    
    @IBAction func startMappingTrail(sender: AnyObject) {
        manager.startUpdatingLocation()
    }
    
    @IBAction func stopMappingTrail(sender: AnyObject) {
        manager.stopUpdatingLocation()
    }
    
    @IBAction func saveTrail(sender: AnyObject) {
        
        let attributedStringTitle = NSAttributedString(string: "Save Custom Trail", attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(22),
            NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            ])
        let attributedStringMessage = NSAttributedString(string: "Enter the name of the trail.", attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(15),
            NSForegroundColorAttributeName : UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
            ])
        let saveAlert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
        
        saveAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
        saveAlert.setValue(attributedStringMessage, forKey: "attributedMessage")
        
        saveAlert.view.tintColor = UIColor.whiteColor();
        
        saveAlert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Some default text."
        })
        
        saveAlert.addAction(UIAlertAction(title: "Save", style: .Default , handler: { (action) -> Void in
            let textField = saveAlert.textFields![0] as UITextField
            self.saveNewTrail(textField.text!, trailCoordinates: self.trailcoordinates)
            print("Text field: \(textField.text)")
            let newTrail = self.customTrail[0]
            print(newTrail.valueForKey("trailName"))
            print(newTrail.valueForKey("trailNum"))
            print(newTrail.valueForKey("overlay"))
            self.customTrail = []
            self.trailcoordinates = []
            print(self.customTrail)
            print(self.trailcoordinates)
        }))
        saveAlert.addAction(UIAlertAction(title: "Cancel", style: .Destructive, handler: nil))
        
        let subview = saveAlert.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
        
        self.presentViewController(saveAlert, animated: true, completion: nil)
        
        alertContentView.layer.cornerRadius = 12;
    
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
        trailcoordinates.append(locations[0] as CLLocation)

        //trailcoordinates.append(manager.location!.coordinate)
        
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

            let s = trailcoordinates[sourceIndex].coordinate
            let d = trailcoordinates[destinationIndex].coordinate
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
    
    func saveNewTrail(name: String, trailCoordinates: [CLLocation]){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("CustomTrails", inManagedObjectContext:managedContext)
        let newTrail = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        newTrail.setValue(name, forKey: "trailName")
        newTrail.setValue(1, forKey: "trailNum")
        newTrail.setValue(trailCoordinates, forKeyPath: "overlay")
        
        do {
            try managedContext.save()
            customTrail.append(newTrail)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
