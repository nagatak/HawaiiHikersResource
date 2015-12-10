//
//  ViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 10/27/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locManager: CLLocationManager?
    
    var pinCoordinate: CLLocationCoordinate2D!
    
    var destination: MKMapItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager = CLLocationManager()
        locManager?.delegate = self
        locManager?.desiredAccuracy = kCLLocationAccuracyBest
        locManager?.requestAlwaysAuthorization()
        locManager?.startUpdatingLocation()
        
        // Sets map type to hybrid
        mapView.mapType = MKMapType.Hybrid
        
        // Set initial location to The Big Island, Hawaii
        let initialLocation = CLLocation(latitude: 19.5667, longitude: -155)
        // Rectangular region to display zoom level
        let regionRadius: CLLocationDistance = 140000
        
        // Function to start the initial screen on the center of The Big Island, Hawaii
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        // Call helper method to zoom into initialLocation on startup
        centerMapOnLocation(initialLocation)
        
        // Datasets for trail locations including trail name, GPS coordinates, & subtitle
        let akaka = PinInfo(title: "Akaka Falls Loop Trail", coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), subtitle: "Akaka Falls State Park")
        let lava = PinInfo(title: "Lava Tree Troop Trail", coordinate: CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300), subtitle: "Lava Tree State Monument")
        let college = PinInfo(title: "College Hall Trail", coordinate: CLLocationCoordinate2D(latitude: 19.703202, longitude: -155.079654), subtitle: "UH Hilo")
        let kilauea = PinInfo(title: "Kilauea Iki Trail", coordinate: CLLocationCoordinate2D(latitude: 19.416333, longitude: -155.242804), subtitle: "Hawaii Volcanoes National Park")
        let kahakai = PinInfo(title: "Ala Kahakai Trail", coordinate: CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178), subtitle: "Kings Trail")
        
        // Adds the datasets into the map as pin annotations
        mapView.addAnnotations([akaka, lava, college, kilauea, kahakai])
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        
        let identifier = "PinInfo"
        
        if annotation.isKindOfClass(PinInfo.self)
        {
            
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil
            {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            }
            else
            {
                
                annotationView!.annotation = annotation
            
            }
            
            //configureDetailView(annotationView!)
            
            return annotationView
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            
            pinCoordinate = view.annotation?.coordinate
            pinMenu()
    }
    
//    func configureDetailView(annotationView: MKAnnotationView) {
//        let width = 300
//        let height = 200
//        
//        let snapshotView = UITableView()
//        let views = ["snapshotView": snapshotView]
//        snapshotView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[snapshotView(300)]", options: [], metrics: nil, views: views))
//        snapshotView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[snapshotView(200)]", options: [], metrics: nil, views: views))
//        
//        let options = MKMapSnapshotOptions()
//        options.size = CGSize(width: width, height: height)
//        options.mapType = .SatelliteFlyover
//        options.camera = MKMapCamera(lookingAtCenterCoordinate: annotationView.annotation!.coordinate, fromDistance: 250, pitch: 65, heading: 0)
//        
//        let snapshotter = MKMapSnapshotter(options: options)
//        snapshotter.startWithCompletionHandler { snapshot, error in
//            if snapshot != nil {
//                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//                imageView.image = snapshot!.image
//                snapshotView.addSubview(imageView)
//            }
//        }
//        
//        annotationView.detailCalloutAccessoryView = snapshotView
//    }
    
    func pinMenu() {
        becomeFirstResponder()
        
        var menu = UIMenuController.sharedMenuController()
        var parkInfo = UIMenuItem(title: "Park Info", action: Selector("infoPark"))
        var trailInfo = UIMenuItem(title: "Trail Info", action: Selector("infoTrail"))
        var directions = UIMenuItem(title: "Directions", action: Selector("directions"))
        var weather = UIMenuItem(title: "Weather", action: Selector("weather"))
        
        menu.menuItems = [parkInfo, trailInfo, weather, directions]
        menu.setTargetRect(CGRectMake(100, 80, 50, 50), inView: mapView)
        menu.setMenuVisible(true, animated: true)
    }
    
    // Functions to segue to respective scenes in storyboard
    func infoPark() {
        performSegueWithIdentifier("parkInfoIdentifier", sender: nil)
    }
    func infoTrail() {
        performSegueWithIdentifier("trailInfoIdentifier", sender: nil)
    }
    func weather() {
        performSegueWithIdentifier("weatherIdentifier", sender: nil)
    }
    func directions() {
        //performSegueWithIdentifier("directionsIdentifier", sender: nil)
        
        
        //        let dest = CLLocationCoordinate2D()
        
        let request = MKDirectionsRequest()
//        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), addressDictionary: nil))
//        
//        source.name = "Akaka Falls"
//        request.source = source
//        
//        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300), addressDictionary: nil))
//        destination.name = "Lava Tree"
//        request.destination = destination
        
        if pinCoordinate.latitude == 19.865850{destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), addressDictionary: nil))}
        else if pinCoordinate.latitude == 19.482842{destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300), addressDictionary: nil))}
        else if pinCoordinate.latitude == 19.703202{destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.703118, longitude: -155.079461), addressDictionary: nil))}
        else if pinCoordinate.latitude == 19.416333{destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.416409, longitude: -155.242834), addressDictionary: nil))}
        else if pinCoordinate.latitude == 19.670625{destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178), addressDictionary: nil))}
        else {destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.5667, longitude: -155), addressDictionary: nil))}
        
        request.transportType = MKDirectionsTransportType.Automobile
        
        var mapItem = destination
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMapsWithLaunchOptions(launchOptions)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        // You need to only return true for the actions you want, otherwise you get the whole range of
        //  iOS actions. You can see this by just removing the if statement here.
        if action == Selector("infoPark") {
            return true
        }
        if action == Selector("infoTrail") {
            return true
        }
        if action == Selector("directions") {
            return true
        }
        if action == Selector("weather") {
            return true
        }
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "trailInfoIdentifier")
        {
            var svc = segue.destinationViewController as! TrailInfoController
            
            svc.toPass = pinCoordinate
        }
        if(segue.identifier == "parkInfoIdentifier")
        {
            var svc = segue.destinationViewController as! ParkInfoController
            
            svc.toPass = pinCoordinate
        }
    }
}

