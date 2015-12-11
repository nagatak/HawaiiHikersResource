////
////  DirectionsViewController.swift
////  HawaiiHikersResource
////
////  Created by Kenneth Nagata on 11/24/15.
////  Copyright © 2015 Kenneth Nagata. All rights reserved.
////


//TODO: Currently not used, delete if we stick with the native navigation app


//
//import MapKit
//
//class DirectionsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
//    
//    // TODO: Figure out directions application
////    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!) {
////            let location = view.annotation as! PinInfo
////            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
////            location.mapItem().openInMapsWithLaunchOptions(launchOptions)
////    }
//    
//    @IBOutlet weak var directDel: MKMapView!
//    
//    var locationManager: CLLocationManager!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Creating instance of CLManager
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        // Setting desired accuracy to best
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        // Request location services authorization from user
//        locationManager.requestAlwaysAuthorization()
//        // Start updating location
//        locationManager.startUpdatingLocation()
//        
//
//        let request = MKDirectionsRequest()
//        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), addressDictionary: nil))
//        
//        source.name = "Akaka Falls"
//        request.source = source
//        
//        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300), addressDictionary: nil))
//        destination.name = "Lava Tree"
//        request.destination = destination
//        
//        request.transportType = MKDirectionsTransportType.Automobile
//        
//        var placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), addressDictionary: nil)
//        var mapItem = destination
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
//        mapItem.openInMapsWithLaunchOptions(launchOptions)
//    
////        request.source = MKMapItem.mapItemForCurrentLocation()
////        request.destination =
////        request.requestsAlternateRoutes = false
////        
////        let directions = MKDirections(request: request)
////        
////        directions.calculateDirectionsWithCompletionHandler({(response:
////            MKDirectionsResponse!, error: NSError!) in
////            
////            if error != nil {
////                // Handle error
////            } else {
////                self.showRoute(response)
////            }
////            
////        }
//    }
//    
////    func openInMapsAutomobile(coord:CLLocationCoordinate2D) {
////        var placemark = MKPlacemark(coordinate: coord, addressDictionary: nil)
////        var mapItem = MKMapItem(placemark: placemark)
////        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
////        mapItem.openInMapsWithLaunchOptions(launchOptions)
////    }
//}
