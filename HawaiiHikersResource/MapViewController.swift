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

    @IBOutlet weak var menuMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set map view delegate
        // self.menuMap.delegate = self
        
        // Sets map type to hybrid
        menuMap.mapType = MKMapType.Hybrid
        
        // Set initial location to The Big Island, Hawaii
        let initialLocation = CLLocation(latitude: 19.5667, longitude: -155)
        // Rectangular region to display zoom level
        let regionRadius: CLLocationDistance = 140000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
            menuMap.setRegion(coordinateRegion, animated: true)
        }
        
        // Call helper method to zoom into initialLocation on startup
        centerMapOnLocation(initialLocation)
        
        // Pin for Akaka falls
        let point1 = MKPointAnnotation()
        point1.coordinate = CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115)
        point1.title = "'Akaka Falls Loop Trail"
        point1.subtitle = "'Akaka Falls State Park"
        
        // Pin for lava tree loop trail
        let point2 = MKPointAnnotation()
        point2.coordinate = CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300)
        point2.title = "Lava Tree Loop Trail"
        point2.subtitle = "Lava Tree State Monument"
        
        // Pin for college hall
        let point3 = MKPointAnnotation()
        point3.coordinate = CLLocationCoordinate2D(latitude: 19.703202, longitude: -155.079654)
        point3.title = "College Hall Trail"
        point3.subtitle = "UH Hilo"
        
        // Pin for Kilauea Iki Trailhead
        let point4 = MKPointAnnotation()
        point4.coordinate = CLLocationCoordinate2D(latitude: 19.416333, longitude: -155.242804)
        point4.title = "Kilauea Iki Trail"
        point4.subtitle = "Hawaii Volcanoes National Park"
        
        // Pin for Ala Kahakai Trail
        let point5 = MKPointAnnotation()
        point5.coordinate = CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178)
        point5.title = "Ala Kahakai Trail"
        point5.subtitle = "Kings TRail"
        
        
        
        // Add annotation `point` for Akaka Falls
        menuMap.addAnnotation(point1)
        // Add annotation `point` for Lava tree loop trail
        menuMap.addAnnotation(point2)
        // Add annotation `point` for college hall
        menuMap.addAnnotation(point3)
        // Add annotation `point` for kilauea iki trail
        menuMap.addAnnotation(point4)
        // Add annotation `point` for Ala Kahakai
        menuMap.addAnnotation(point5)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

