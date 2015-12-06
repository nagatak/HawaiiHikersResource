//
//  TrailMapViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import UIKit
import MapKit

enum MapType: Int {
    case Standard = 0
    case Hybrid
    case Satellite
}


class TrailMapViewController: UIViewController {

    @IBOutlet weak var trailMapView: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailMapView.delegate = self
        
        mapUH()
        mapAkaka()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapUH(){
        var points = [CLLocationCoordinate2DMake(19.703111, -155.079463), CLLocationCoordinate2DMake(19.702917, -155.079327), CLLocationCoordinate2DMake(19.7022811, -155.079489), CLLocationCoordinate2DMake(19.702709, -155.07952),
            CLLocationCoordinate2DMake(19.702672, -155.079952)]
        
        let trail = MKPolyline(coordinates: &points, count: points.count)
        trailMapView.addOverlay(trail)
    }
    
    func mapAkaka(){
        var points = [CLLocationCoordinate2DMake(19.854144, -155.152367), CLLocationCoordinate2DMake(19.854522, -155.152287), CLLocationCoordinate2DMake(19.8554, -155.152254), CLLocationCoordinate2DMake(19.855688, -155.151895), CLLocationCoordinate2DMake(19.855925, -155.151895), CLLocationCoordinate2DMake(19.855743, -155.151922), CLLocationCoordinate2DMake(19.855587, -155.15226), CLLocationCoordinate2DMake(19.855598, -155.152339), CLLocationCoordinate2DMake(19.855382, -155.152637), CLLocationCoordinate2DMake(19.8549, -155.152929), CLLocationCoordinate2DMake(19.854415, -155.15331), CLLocationCoordinate2DMake(19.854292, -155.15368), CLLocationCoordinate2DMake(19.85388, -155.154069), CLLocationCoordinate2DMake(19.853815, -155.154077), CLLocationCoordinate2DMake(19.853757, -155.154029), CLLocationCoordinate2DMake(19.853719, -155.153814), CLLocationCoordinate2DMake(19.853911, -155.152763), CLLocationCoordinate2DMake(19.853809, -155.152533), CLLocationCoordinate2DMake(19.85397, -155.152448), CLLocationCoordinate2DMake(19.854091, -155.152435), CLLocationCoordinate2DMake(19.85415, -155.152378)]
        
        let trail = MKPolyline(coordinates: &points, count: points.count)
        trailMapView.addOverlay(trail)
    }
    
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
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return nil
    }
    
    
}


extension TrailMapViewController: MKMapViewDelegate {
}
