//
//  ViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 10/27/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
///

import UIKit
import CoreLocation
import MapKit
import CoreData
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    // Interface builder for mapView
    @IBOutlet weak var mapView: MKMapView!
    // Declaration of variables
    var locManager: CLLocationManager?
    var pinCoordinate: CLLocationCoordinate2D!
    var destination: MKMapItem!
    var customTrailMaps = [NSManagedObject]()
    var cstmTrailArray = [PinInfo]()
    let shareData = ShareData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        mapView.mapType = MKMapType.hybrid
        
        // Set initial location to The Big Island, Hawaii
        let initialLocation = CLLocation(latitude: 19.619305, longitude: -155.478945)
        // Rectangular region to display zoom level
        let regionRadius: CLLocationDistance = 80000
        
        // Function to start the initial screen on the center of The Big Island, Hawaii
        func centerMapOnLocation(_ location: CLLocation) {
            // Rectangular region of map to be viewed
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
            // Set the region to be viewed with animation
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
        
        //addCustomTrails()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MapViewController.handleSwipes(_:)))
        
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(rightSwipe)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        //addCustomTrails()
    }
    
    @IBAction func listTrailsBtn(_ sender: UIBarButtonItem) {
        
        //print("pressed")
        
        let attributedStringTitle = NSAttributedString(string: "Select a Trail", attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 22),
            NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            ])
        
        let trailListAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        
        trailListAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
        
        trailListAlert.view.tintColor = UIColor.white
        
        trailListAlert.addAction(UIAlertAction(title: "'Akaka Falls Loop Trail", style: .default, handler: { (action) -> Void in
            self.pinCoordinate = CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115)
            self.alertMenu("'Akaka Falls Loop Trail")
        }))
        trailListAlert.addAction(UIAlertAction(title: "Lava Trees Loop Trail", style: .default, handler: { (action) -> Void in
            self.pinCoordinate = CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300)
            self.alertMenu("Lava Trees Loop Trail")
        }))
        trailListAlert.addAction(UIAlertAction(title: "College Hall Trail", style: .default, handler: { (action) -> Void in
            self.pinCoordinate = CLLocationCoordinate2D(latitude: 19.703202, longitude: -155.079654)
            self.alertMenu("College Hall Trail")
        }))
        trailListAlert.addAction(UIAlertAction(title: "Kilauea Iki", style: .default, handler: { (action) -> Void in
            self.pinCoordinate = CLLocationCoordinate2D(latitude: 19.416333, longitude: -155.242804)
            self.alertMenu("Kilauea Iki")
        }))    
        trailListAlert.addAction(UIAlertAction(title: "Ala Kahakai Trail", style: .default, handler: { (action) -> Void in
            self.pinCoordinate = CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178)
            self.alertMenu("Ala Kahakai Trail")
        }))
        trailListAlert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
        
        
        let subview = trailListAlert.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
        
        self.present(trailListAlert, animated: true, completion: nil)
        
        alertContentView.layer.cornerRadius = 12
    }
    
    func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .right){
            //performSegueWithIdentifier("menuSwipeSegue", sender: self)
        }
    }
    
    @IBAction func menuBtn(_ sender: UIBarButtonItem) {
        let attributedStringTitle = NSAttributedString(string: "Select an Option", attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 22),
            NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            ])
        
        let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
        
        menuAlert.view.tintColor = UIColor.white
        
        menuAlert.addAction(UIAlertAction(title: "User Info", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "mapUserSegue", sender: nil)
        }))
        
        menuAlert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) -> Void in
        }))
        
        menuAlert.addAction(UIAlertAction(title: "Edit Custom Trail", style: .default, handler: { (action) -> Void in self.performSegue(withIdentifier: "ctmIdentifier", sender: nil)
        }))
        
        menuAlert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
        
        let subview = menuAlert.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
        
        self.present(menuAlert, animated: true, completion: nil)
        
        alertContentView.layer.cornerRadius = 12
    }
    
//    func addCustomTrails(){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.managedObjectContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomTrails")
//        
//        do {
//            let results = try managedContext.fetch(fetchRequest)
//            customTrailMaps = results as! [NSManagedObject]
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
//        
//        if (customTrailMaps.count > 0){
//            
//            for (index,element) in customTrailMaps.enumerated(){
//                let tempName = element.value(forKey: "trailName")
//                let tempOver = element.value(forKey: "overlay")
//                if (tempOver as AnyObject).count > 0{
//                    cstmTrailArray.append(PinInfo(title: tempName! as! String, coordinate: tempOver![0].coordinate, subtitle: " "))
//                }
//            }
//            if(cstmTrailArray.count - 1 >= 0){
//                for num in 0 ... cstmTrailArray.count - 1{
//                    mapView.addAnnotations([cstmTrailArray[num]])
//                }
//            }
//        }
//       
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Overloaded function to place annotations on map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let identifier = "PinInfo"
        
        if annotation.isKind(of: PinInfo.self)
        {
            // Creates a reusable template for the PinInfo class
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            // Creates a new annotation
            if annotationView == nil
            {
                // Set style of pin
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = false
                // Creats info button in pin annotation
                let btn = UIButton(type: .detailDisclosure)
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
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        if !(view.annotation!.isKind(of: MKUserLocation.self)) {
            pinCoordinate = view.annotation?.coordinate
            alertMenu(view.annotation!.title!!)
            mapView.deselectAnnotation(view.annotation, animated: false)
        }
        
    }
    
    // Overloaded function to tell what to do when right callout accessory button is pressed
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
            // Gets the current pin coordinates
            pinCoordinate = view.annotation?.coordinate
            // Calls the pinMenu function when pin is tapped
            //pinMenu()
            //alertMenu()
    }
    
    // 
    func alertMenu(_ trailName: String){
        let attributedStringTitle = NSAttributedString(string: trailName, attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 22),
            NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
            ])
//        let attributedStringMessage = NSAttributedString(string: "Enter the name of the trail.", attributes: [
//            NSFontAttributeName : UIFont.systemFontOfSize(15),
//            NSForegroundColorAttributeName : UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
//            ])
        let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
        //menuAlert.setValue(attributedStringMessage, forKey: "attributedMessage")
        
        menuAlert.view.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1);
        
        menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .default , handler: { (action) -> Void in
            self.performSegue(withIdentifier: "trailInfoIdentifier", sender: nil)
        }))
        menuAlert.addAction(UIAlertAction(title: "Park Info", style: .default , handler: { (action) -> Void in
            self.performSegue(withIdentifier: "parkInfoIdentifier", sender: nil)
        }))
        menuAlert.addAction(UIAlertAction(title: "Weather", style: .default , handler: { (action) -> Void in
            self.performSegue(withIdentifier: "weatherIdentifier", sender: nil)
        }))
        menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .default , handler: { (action) -> Void in
            self.performSegue(withIdentifier: "previewIdentifier", sender: nil)
        }))
        menuAlert.addAction(UIAlertAction(title: "Directions", style: .default , handler: { (action) -> Void in
            // Creates an instance of MKDirectionsRequest
            let request = MKDirectionsRequest()
            
            // Determines the destination according to the current pin selected
            if self.pinCoordinate.latitude == 19.865850{self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), addressDictionary: nil))}
            else if self.pinCoordinate.latitude == 19.482842{self.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300), addressDictionary: nil))}
            else if self.pinCoordinate.latitude == 19.703202{self.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.703118, longitude: -155.079461), addressDictionary: nil))}
            else if self.pinCoordinate.latitude == 19.416333{self.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.416409, longitude: -155.242834), addressDictionary: nil))}
            else if self.pinCoordinate.latitude == 19.670625{self.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178), addressDictionary: nil))}
            else {self.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.5667, longitude: -155), addressDictionary: nil))}
            
            // Defaults the transportation type as an automobile
            request.transportType = MKDirectionsTransportType.automobile
            
            // Sets the destination
            let mapItem = self.destination
            // Sets the launch options for the native navigation app
            let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
            // Launches the native navigation app
            mapItem?.openInMaps(launchOptions: launchOptions)
        }))
        
        menuAlert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
        
        let subview = menuAlert.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        self.present(menuAlert, animated: true, completion: nil)
        
        alertContentView.layer.cornerRadius = 12;
    }
    
    // Creates a new UIMenuController
    func pinMenu() {
        // Allows the menu to becomeFirstResponder
        becomeFirstResponder()
        
        // Creating the menu
        let menu = UIMenuController.shared
        // Declares 4 buttons
        let parkInfo = UIMenuItem(title: "Park Info", action: #selector(MapViewController.infoPark))
        let trailInfo = UIMenuItem(title: "Trail Info", action: #selector(MapViewController.infoTrail))
        let directions = UIMenuItem(title: "Directions", action: #selector(MapViewController.directions))
        let weather = UIMenuItem(title: "Weather", action: #selector(MapViewController.weather))
        
        // Adds the 4 buttons to the menu
        menu.menuItems = [parkInfo, trailInfo, weather, directions]
        // Menu size and location on screen
        menu.setTargetRect(CGRect(x: 100, y: 80, width: 50, height: 50), in: mapView)
        // Sets the menu to be visible
        menu.setMenuVisible(true, animated: true)
    }
    
    // Functions to segue to respective scenes in storyboard
    func infoPark() {
        performSegue(withIdentifier: "parkInfoIdentifier", sender: nil)
    }
    func infoTrail() {
        performSegue(withIdentifier: "trailInfoIdentifier", sender: nil)
    }
    func weather() {
        performSegue(withIdentifier: "weatherIdentifier", sender: nil)
    }
    func directions() {
        // Creates an instance of MKDirectionsRequest
        let request = MKDirectionsRequest()
        
        // Determines the destination according to the current pin selected
        if pinCoordinate.latitude == 19.865850 && pinCoordinate.longitude == -155.116115{destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), addressDictionary: nil))}
        else if pinCoordinate.latitude == 19.482842 && pinCoordinate.longitude == -154.904300{destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300), addressDictionary: nil))}
        else if pinCoordinate.latitude == 19.703202 && pinCoordinate.longitude == -155.079461{destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.703118, longitude: -155.079461), addressDictionary: nil))}
        else if pinCoordinate.latitude == 19.416333 && pinCoordinate.longitude == -155.242834{destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.416409, longitude: -155.242834), addressDictionary: nil))}
        else if pinCoordinate.latitude == 19.670625 && pinCoordinate.longitude == -156.026178{destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178), addressDictionary: nil))}
        else {destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.5667, longitude: -155), addressDictionary: nil))}
        
        // Defaults the transportation type as an automobile
        request.transportType = MKDirectionsTransportType.automobile
        
        // Sets the destination
        let mapItem = destination
        // Sets the launch options for the native navigation app
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        // Launches the native navigation app
        mapItem?.openInMaps(launchOptions: launchOptions)
    }
    
    // Overrides the function allows a new first responder to be designated
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    // Pin menu selection will choose correct function
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // You need to only return true for the actions you want, otherwise you get the whole range of
        //  iOS actions. You can see this by just removing the if statement here.
        if action == #selector(MapViewController.infoPark) {
            return true
        }
        if action == #selector(MapViewController.infoTrail) {
            return true
        }
        if action == #selector(MapViewController.directions) {
            return true
        }
        if action == #selector(MapViewController.weather) {
            return true
        }
        return false
    }
    
    // Override function to allow passing variables between scenes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Checks for trailInfoIdentifier segue
        if(segue.identifier == "trailInfoIdentifier")
        {
            // Creates link from current ViewController to
            let svc = segue.destination as! InfoSceneVC
            
            // Variable to be passed
            svc.toPass = pinCoordinate
            self.shareData.passedCoordinate = pinCoordinate
            svc.initialScene = "trail"
        
        }
        // Checks for parkInfoIdentifier segue
        if(segue.identifier == "parkInfoIdentifier")
        {
            let svc = segue.destination as! InfoSceneVC
            
            // Variable to be passed
            svc.toPass = pinCoordinate
            self.shareData.passedCoordinate = pinCoordinate
            svc.initialScene = "park"
        }
        // Checks for weatherIdentifier segue
        if(segue.identifier == "weatherIdentifier")
        {
            // Creates link from current ViewController to WeatherViewController
            let svc = segue.destination as! InfoSceneVC
            
            // Variable to be passed
            svc.toPass = pinCoordinate
            self.shareData.passedCoordinate = pinCoordinate
            svc.initialScene = "weather"
        }
    }
}

