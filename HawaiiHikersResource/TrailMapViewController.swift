//
//  TrailMapViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//enum used by map type selector to switch maps
enum MapType: Int {
    case Standard = 0
    case Hybrid
    case Satellite
}

class TrailMapViewController: UIViewController {
    
    //Interface builder outlet for trailMapView
    @IBOutlet weak var trailMapView: MKMapView!
    //Interface builder outlet for segemented control (select map type)
    @IBOutlet weak var mapType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailMapView.delegate = self
        
        
        
        // Rectangular region to display zoom level
        let regionRadius: CLLocationDistance = 140000
    
        let pinLocation = CLLocation(latitude: 19.5667, longitude: -155)
        
        // Function to start the trail on the trail map overlay
        func centerMapOnPinLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
            trailMapView.setRegion(coordinateRegion, animated: true)
        }
        
        centerMapOnPinLocation(pinLocation)
        
        //call functions to map overlays
        mapUH()
        mapAkaka()
        mapKilaueaIki()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Map overlay for ch to parking lot
    func mapUH(){
        //array of gps coordinates
        var points = [CLLocationCoordinate2DMake(19.703118, -155.079461), CLLocationCoordinate2DMake(19.702924, -155.079330), CLLocationCoordinate2DMake(19.702808, -155.079504), CLLocationCoordinate2DMake(19.702718, -155.079515),
            CLLocationCoordinate2DMake(19.702678, -155.079586)]
        
        //declaration
        let trail = MKPolyline(coordinates: &points, count: points.count)
        //draws the overlay
        trailMapView.addOverlay(trail)
    }
    
    //Map overlay for akaka falls
    func mapAkaka(){
        //array of gps coordinates
        var points = [CLLocationCoordinate2DMake(19.854144, -155.152367), CLLocationCoordinate2DMake(19.854522, -155.152287), CLLocationCoordinate2DMake(19.8554, -155.152254), CLLocationCoordinate2DMake(19.855688, -155.151895), CLLocationCoordinate2DMake(19.855925, -155.151895), CLLocationCoordinate2DMake(19.855743, -155.151922), CLLocationCoordinate2DMake(19.855587, -155.15226), CLLocationCoordinate2DMake(19.855598, -155.152339), CLLocationCoordinate2DMake(19.855382, -155.152637), CLLocationCoordinate2DMake(19.8549, -155.152929), CLLocationCoordinate2DMake(19.854415, -155.15331), CLLocationCoordinate2DMake(19.854292, -155.15368), CLLocationCoordinate2DMake(19.85388, -155.154069), CLLocationCoordinate2DMake(19.853815, -155.154077), CLLocationCoordinate2DMake(19.853757, -155.154029), CLLocationCoordinate2DMake(19.853719, -155.153814), CLLocationCoordinate2DMake(19.853911, -155.152763), CLLocationCoordinate2DMake(19.853809, -155.152533), CLLocationCoordinate2DMake(19.85397, -155.152448), CLLocationCoordinate2DMake(19.854091, -155.152435), CLLocationCoordinate2DMake(19.85415, -155.152378)]
        
        //declaration
        let trail = MKPolyline(coordinates: &points, count: points.count)
        //draws the overlay
        trailMapView.addOverlay(trail)
    }
    
    //Map Overlay for Kilauea Iki
    func mapKilaueaIki(){
        //array of gps coordinates
        var points = [CLLocationCoordinate2DMake(19.416409,-155.242834),CLLocationCoordinate2DMake(19.416275,-155.242855),CLLocationCoordinate2DMake(19.416212,-155.242847),CLLocationCoordinate2DMake(19.41584,-155.242732),CLLocationCoordinate2DMake(19.415086,-155.242383),CLLocationCoordinate2DMake(19.41416,-155.24197),CLLocationCoordinate2DMake(19.413978,-155.241892),CLLocationCoordinate2DMake(19.413791,-155.241785),CLLocationCoordinate2DMake(19.413619,-155.241571),CLLocationCoordinate2DMake(19.413438,-155.241157),CLLocationCoordinate2DMake(19.413351,-155.240839),CLLocationCoordinate2DMake(19.413319,-155.240639),CLLocationCoordinate2DMake(19.413395,-155.240071),CLLocationCoordinate2DMake(19.413592,-155.239836),CLLocationCoordinate2DMake(19.41384,-155.239238),CLLocationCoordinate2DMake(19.413631,-155.238833),CLLocationCoordinate2DMake(19.41353,-155.238731),CLLocationCoordinate2DMake(19.413283,-155.238971),CLLocationCoordinate2DMake(19.41312,-155.239124),CLLocationCoordinate2DMake(19.413065,-155.239168),CLLocationCoordinate2DMake(19.413008,-155.2392),CLLocationCoordinate2DMake(19.412688,-155.239362),CLLocationCoordinate2DMake(19.412076,-155.239593),CLLocationCoordinate2DMake(19.412053,-155.239623),CLLocationCoordinate2DMake(19.412067,-155.239688),CLLocationCoordinate2DMake(19.4121,-155.239714),CLLocationCoordinate2DMake(19.412148,-155.239729),CLLocationCoordinate2DMake(19.412556,-155.23967),CLLocationCoordinate2DMake(19.412631,-155.239695),CLLocationCoordinate2DMake(19.412686,-155.239746),CLLocationCoordinate2DMake(19.412713,-155.239794),CLLocationCoordinate2DMake(19.412707,-155.239832),CLLocationCoordinate2DMake(19.412657,-155.239919),CLLocationCoordinate2DMake(19.41223,-155.240152),CLLocationCoordinate2DMake(19.411958,-155.240269),CLLocationCoordinate2DMake(19.411549,-155.24038),CLLocationCoordinate2DMake(19.411296,-155.24048),CLLocationCoordinate2DMake(19.411109,-155.240598),CLLocationCoordinate2DMake(19.410941,-155.240796),CLLocationCoordinate2DMake(19.410807,-155.240985),CLLocationCoordinate2DMake(19.410708,-155.241249),CLLocationCoordinate2DMake(19.410701,-155.241337),CLLocationCoordinate2DMake(19.410712,-155.241375),CLLocationCoordinate2DMake(19.410763,-155.24139),CLLocationCoordinate2DMake(19.410827,-155.241358),CLLocationCoordinate2DMake(19.411085,-155.241098),CLLocationCoordinate2DMake(19.411351,-155.240915),CLLocationCoordinate2DMake(19.411549,-155.240828),CLLocationCoordinate2DMake(19.411688,-155.240827),CLLocationCoordinate2DMake(19.411872,-155.240851),CLLocationCoordinate2DMake(19.412028,-155.240933),CLLocationCoordinate2DMake(19.412113,-155.241003),CLLocationCoordinate2DMake(19.412152,-155.241208),CLLocationCoordinate2DMake(19.412111,-155.241357),CLLocationCoordinate2DMake(19.411934,-155.241588),CLLocationCoordinate2DMake(19.411904,-155.241694),CLLocationCoordinate2DMake(19.412024,-155.242115),CLLocationCoordinate2DMake(19.412186,-155.242938),CLLocationCoordinate2DMake(19.412372,-155.243554),CLLocationCoordinate2DMake(19.412627,-155.244628),CLLocationCoordinate2DMake(19.412773,-155.245018),CLLocationCoordinate2DMake(19.412969,-155.245803),CLLocationCoordinate2DMake(19.413323,-155.247065),CLLocationCoordinate2DMake(19.413492,-155.247535),CLLocationCoordinate2DMake(19.413588,-155.248141),CLLocationCoordinate2DMake(19.413805,-155.249604),CLLocationCoordinate2DMake(19.414218,-155.250741),CLLocationCoordinate2DMake(19.414701,-155.251645),CLLocationCoordinate2DMake(19.414643,-155.251983),CLLocationCoordinate2DMake(19.414453,-155.252206),CLLocationCoordinate2DMake(19.414256,-155.252328),CLLocationCoordinate2DMake(19.414161,-155.252456),CLLocationCoordinate2DMake(19.414192,-155.252567),CLLocationCoordinate2DMake(19.414605,-155.253028),CLLocationCoordinate2DMake(19.414736,-155.253181),CLLocationCoordinate2DMake(19.414768,-155.253411),CLLocationCoordinate2DMake(19.414727,-155.253691),CLLocationCoordinate2DMake(19.414709,-155.253732),CLLocationCoordinate2DMake(19.414682,-155.253735),CLLocationCoordinate2DMake(19.414661,-155.253733),CLLocationCoordinate2DMake(19.41463,-155.253805),CLLocationCoordinate2DMake(19.414433,-155.254026),CLLocationCoordinate2DMake(19.414361,-155.254321),CLLocationCoordinate2DMake(19.414615,-155.254552),CLLocationCoordinate2DMake(19.41467,-155.254721),CLLocationCoordinate2DMake(19.414773,-155.254829),CLLocationCoordinate2DMake(19.415029,-155.254949),CLLocationCoordinate2DMake(19.415265,-155.254992),CLLocationCoordinate2DMake(19.415615,-155.255041),CLLocationCoordinate2DMake(19.415647,-155.255088),CLLocationCoordinate2DMake(19.415524,-155.255265),CLLocationCoordinate2DMake(19.415419,-155.255329),CLLocationCoordinate2DMake(19.415427,-155.25535),CLLocationCoordinate2DMake(19.41568,-155.25535),CLLocationCoordinate2DMake(19.415694,-155.255382),CLLocationCoordinate2DMake(19.415682,-155.25541),CLLocationCoordinate2DMake(19.41563,-155.255462),CLLocationCoordinate2DMake(19.415473,-155.255593),CLLocationCoordinate2DMake(19.415477,-155.25563),CLLocationCoordinate2DMake(19.415779,-155.255658),CLLocationCoordinate2DMake(19.418283,-155.254011),CLLocationCoordinate2DMake(19.418349,-155.25392),CLLocationCoordinate2DMake(19.418349,-155.253812),CLLocationCoordinate2DMake(19.418262,-155.25331),CLLocationCoordinate2DMake(19.418176,-155.252901),CLLocationCoordinate2DMake(19.417985,-155.252606),CLLocationCoordinate2DMake(19.417426,-155.25208),CLLocationCoordinate2DMake(19.417216,-155.251919),CLLocationCoordinate2DMake(19.416563,-155.250636),CLLocationCoordinate2DMake(19.416662,-155.25006),CLLocationCoordinate2DMake(19.417067,-155.24955),CLLocationCoordinate2DMake(19.41739,-155.247911),CLLocationCoordinate2DMake(19.417395,-155.245098),CLLocationCoordinate2DMake(19.417249,-155.24436),CLLocationCoordinate2DMake(19.417347,-155.243716),CLLocationCoordinate2DMake(19.417265,-155.243329),CLLocationCoordinate2DMake(19.416841,-155.242915),CLLocationCoordinate2DMake(19.416416,-155.242829),CLLocationCoordinate2DMake(19.416409,-155.242834)]
        
        //declaration
        let trail = MKPolyline(coordinates: &points, count: points.count)
        //draws the overlay
        trailMapView.addOverlay(trail)
    }
    
    //Interface Builder action, switches map type according to segmented control selection
    @IBAction func mapTypeControl(sender: AnyObject) {
        let mapTypeC = MapType(rawValue: mapType.selectedSegmentIndex)
        switch (mapTypeC!) {
        case .Standard:
            trailMapView.mapType = MKMapType.Standard
        case .Hybrid:
            trailMapView.mapType = MKMapType.Hybrid
        case .Satellite:
            trailMapView.mapType = MKMapType.Satellite
        }
    }
    
    //Draws the overlay, takes an array of gps coorditates and draws a line between each coordinate.
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.grayColor()
            polylineRenderer.lineWidth = 6
            return polylineRenderer
        }
        return nil
    }
    
    
}

//Extend the trailMapViewController as delegate
extension TrailMapViewController: MKMapViewDelegate {
}