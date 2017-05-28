//
//  InfoSceneVC.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 5/3/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation



class InfoSceneVC: UIViewController {
    
    @IBOutlet weak var segmentControl: ADVSegmentedControl!
    @IBOutlet weak var trailCV: UIView!
    @IBOutlet weak var parkCV: UIView!
    @IBOutlet weak var weatherCV: UIView!
    
    var toPass: CLLocationCoordinate2D!
    var initialScene: String = ""
    var passedCoord: CLLocationCoordinate2D!
    
    let shareData = ShareData.sharedInstance
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        selectInitialScene(initialScene)
        segmentControl.items = ["Trail", "Park", "Weather"]
        segmentControl.font = UIFont(name: "Avenir-Black", size: 12)
        segmentControl.borderColor = UIColor(white: 1.0, alpha: 0.3)
        //segmentControl.selectedIndex = 0
        segmentControl.addTarget(self, action: #selector(InfoSceneVC.segmentValueChanged(_:)), for: .valueChanged)
        
    }
    
    func selectInitialScene(_ s:String){
        
        if s == "trail"{
            self.trailCV.alpha = 1
            self.parkCV.alpha = 0
            self.weatherCV.alpha = 0
            segmentControl.selectedIndex = 0
        } else if s == "park" {
            self.trailCV.alpha = 0
            self.parkCV.alpha = 1
            self.weatherCV.alpha = 0
            segmentControl.selectedIndex = 1
        } else {
            self.trailCV.alpha = 0
            self.parkCV.alpha = 0
            self.weatherCV.alpha = 1
            segmentControl.selectedIndex = 2
        }
        
    }
    
    func segmentValueChanged(_ sender: AnyObject?){
        
        if segmentControl.selectedIndex == 0 {
            self.trailCV.alpha = 1
            self.parkCV.alpha = 0
            self.weatherCV.alpha = 0
        }else if segmentControl.selectedIndex == 1{
            self.trailCV.alpha = 0
            self.parkCV.alpha = 1
            self.weatherCV.alpha = 0
        }else{
            self.trailCV.alpha = 0
            self.parkCV.alpha = 0
            self.weatherCV.alpha = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Checks for trailInfoIdentifier segue
        if(segue.identifier == "trailInfoIdentifier")
        {
            // Creates link from current ViewController to TrailInfoController
            let svc = segue.destination as! TrailInfoController
            
            // Variable to be passed
            svc.toPass = passedCoord
        }
        // Checks for parkInfoIdentifier segue
        if(segue.identifier == "parkCVIdentifier")
        {
            let svc = segue.destination as! ParkInfoController
            
            // Variable to be passed
            svc.toPass = passedCoord
        }
        // Checks for weatherIdentifier segue
        if(segue.identifier == "weatherIdentifier")
        {
            // Creates link from current ViewController to WeatherViewController
            let svc = segue.destination as! WeatherViewController
            
            // Variable to be passed
            svc.toPass = passedCoord
        }
    }
}
