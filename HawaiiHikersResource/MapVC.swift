//
//  MapVC.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 4/12/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit
import MapKit
import Foundation
import CoreLocation


class MapVC: UIViewController, UIPopoverPresentationControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate{
    
    // MARK: Properties
    
    // Declaration of variables
    var locManager: CLLocationManager?
    var pinCoordinate: CLLocationCoordinate2D!
    var destination: MKMapItem!
    
    let shareData = ShareData.sharedInstance
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var listBtn: UIBarButtonItem!

    
    @IBAction func qVMBtn(sender: UIBarButtonItem) {

        performSegueWithIdentifier("menuBtnSegue", sender: nil)
        
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("QVMenuVC")
//        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
//        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
//        popover.barButtonItem = sender
//        popover.delegate = self
//        presentViewController(vc, animated: true, completion:nil)
    }
    
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let btnDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(MapVC.dismiss))
        navigationController.topViewController!.navigationItem.rightBarButtonItem = btnDone
        return navigationController
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    var slideDownManager = SlideDownManager()
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.sourceViewController as! MenuVC
        //self.title = sourceController.currentItem
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            listBtn.target = self.revealViewController()
            listBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.shareData.passedCoordinate = CLLocationCoordinate2D(latitude: 19.5667, longitude: -155)
        
        // Creating instance of CLManager
        locManager = CLLocationManager()
        locManager?.delegate = self
        // Setting desired accuracy to best
        locManager?.desiredAccuracy = kCLLocationAccuracyBest
        // Request location services authorization from user
        locManager?.requestAlwaysAuthorization()
        // Start updating location
        locManager?.startUpdatingLocation()
        
        // Sets map type to hybrid
        mapView.mapType = MKMapType.Hybrid
        
        // Set initial location to The Big Island, Hawaii
        let initialLocation = CLLocation(latitude: 19.5667, longitude: -155)
        // Call helper method to zoom into initialLocation on startup
        centerMapOnLocation(initialLocation)
        
        generatePins()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generatePins(){

                //select json file to retrieve data from
                let trailURL: NSURL = [#FileReference(fileReferenceLiteral: "trailInfo.json")#]
                let trailData = NSData(contentsOfURL: trailURL)!
//        var tName: String = ""
//        var tLat: String = ""
//        var tLon: String = ""
//        var tSub: String = ""
        var pinLoc: [PinInfo] = []
//        var tPin =  PinInfo(title: " ", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), subtitle: " ")
//
//                do{
//                    let json = try NSJSONSerialization.JSONObjectWithData(trailData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
////                    // Print dict
////                    for (key, value) in json! {
////                        print("\(key) -> \(value)")
////                    }
////                    
//                    for (key, value) in json!{
//                        if let trails = json?.objectForKey(key){
//                            if let trailName = trails.objectForKey("trailName") as? String{
//                                tName = trailName
//                            }
//                            if let trailLat = trails.objectForKey("lat") as? String{
//                                tLat = trailLat
//                            }
//                            if let trailLon = trails.objectForKey("lon") as? String{
//                                tLon = trailLon
//                            }
//                        }
//                        
//                    }
//                    
//                    let cLat = (tLat as NSString).doubleValue
//                    let cLon = (tLon as NSString).doubleValue
//                    
//                    
//                    
//                    tPin.title = tName
//                    tPin.coordinate = CLLocationCoordinate2D(latitude: cLat, longitude: cLon)
//                    tPin.subtitle = " "
//
//                    pinLoc.append(tPin)
//                
//                } catch {
//                    print("error serializing JSON: \(error)")
//                }
        
        
        // Datasets for trail locations including trail name, GPS coordinates, & subtitle
        let akaka = PinInfo(title: "Akaka Falls Loop Trail", coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), subtitle: "Akaka Falls State Park")
        let lava = PinInfo(title: "Lava Tree Troop Trail", coordinate: CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300), subtitle: "Lava Tree State Monument")
        let college = PinInfo(title: "College Hall Trail", coordinate: CLLocationCoordinate2D(latitude: 19.703202, longitude: -155.079654), subtitle: "UH Hilo")
        let kilauea = PinInfo(title: "Kilauea Iki Trail", coordinate: CLLocationCoordinate2D(latitude: 19.416333, longitude: -155.242804), subtitle: "Hawaii Volcanoes National Park")
        let kahakai = PinInfo(title: "Ala Kahakai Trail", coordinate: CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178), subtitle: "Kings Trail")

        pinCoordinate = akaka.coordinate
        
        pinLoc = [akaka, lava, college, kilauea, kahakai]
        
        // Adds the datasets into the map as pin annotations
        mapView.addAnnotations(pinLoc)
        
        
    }
    
    
    func centerMapOnLocation(location: CLLocation) {

        // Rectangular region to display zoom level
        let regionRadius: CLLocationDistance = 140000
        
        // Rectangular region of map to be viewed
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        // Set the region to be viewed with animation
        mapView.setRegion(coordinateRegion, animated: true)
    }

    // MARK: Annotation
    
    // Overloaded function to place annotations on map
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        let identifier = "PinInfo"

        if annotation.isKindOfClass(PinInfo.self)
        {
            // Creates a reusable template for the PinInfo class
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)

            // Creates a new annotation
            if annotationView == nil
            {
                // Set style of pin
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = false
                // Creats info button in pin annotation
                let btn = UIButton(type: .DetailDisclosure)
                // Set button as right callout accessory
                annotationView!.rightCalloutAccessoryView = btn
            }
            else
            {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
        // Calls uialertmenu instead of annotation callout
        func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    
            if !(view.annotation!.isKindOfClass(MKUserLocation)) {
                pinCoordinate = view.annotation?.coordinate
                // Creates link from current ViewController to TrailInfoController
                
                
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("QVMenuVC")
                vc.modalPresentationStyle = UIModalPresentationStyle.Popover
                let popover: UIPopoverPresentationController = vc.popoverPresentationController!
                popover.sourceView = view
                popover.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds), 0, 0)
                popover.delegate = self
                presentViewController(vc, animated: true, completion:nil)
            }
            
        }
    
    // MARK: - Navigation
     
     // MARK: Prepare for Segue
     
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "menuSegueIdentifier"){
            let menuVC = segue.destinationViewController as! MenuVC
            menuVC.transitioningDelegate = self.slideDownManager
            menuVC.toPass = pinCoordinate
        }
        if(segue.identifier == "menuBtnSegue"){
            if let destination = segue.destinationViewController as? QuickViewMenuVC{
                destination.toPass = pinCoordinate
            }
      }
    }
}

//protocol MyProtocol: class
//{
//    func passCoordinates(passedCoordinate:CLLocationCoordinate2D!)
//}








