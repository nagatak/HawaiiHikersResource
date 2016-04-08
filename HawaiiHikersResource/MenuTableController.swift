//
//  MenuTableController.swift
//  HawaiiHikersResource
//
//  Created by Ray Manzano on 4/6/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit
import MapKit

class MenuTableController: UITableViewController {
    
    var menuTableData: NSMutableArray = []
    var pinCoordinate: CLLocationCoordinate2D!
    var destination: MKMapItem!
    
    @IBAction func menuTable(sender: AnyObject) {
        let attributedStringTitle = NSAttributedString(string: "Select an Option", attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(22),
            NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            ])
        
        let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
        
        menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
        
        menuAlert.view.tintColor = UIColor.whiteColor()
        
        menuAlert.addAction(UIAlertAction(title: "User Info", style: .Default, handler: { (action) -> Void in
            self.performSegueWithIdentifier("userInfoSegue", sender: nil)
        }))
        
        menuAlert.addAction(UIAlertAction(title: "Settings", style: .Default, handler: { (action) -> Void in
        }))
        menuAlert.addAction(UIAlertAction(title: "Create Custom Trail", style: .Default, handler: { (action) -> Void in self.performSegueWithIdentifier("ctmMenu", sender: nil)
        }))
        
        menuAlert.addAction(UIAlertAction(title: "Close", style: .Destructive, handler: nil))
        
        let subview = menuAlert.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
        
        self.presentViewController(menuAlert, animated: true, completion: nil)
        
        alertContentView.layer.cornerRadius = 12
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.toolbarHidden = false
        
        menuTableData.addObject("Trails")
        loadTrailName("akaka001")
        //passedCoord = CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115)
        loadTrailName("lavatree001")
        loadTrailName("uh")
        loadTrailName("havo001")
        loadTrailName("king001")
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        
        view.addGestureRecognizer(leftSwipe)
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        
        if (sender.direction == .Left){
            performSegueWithIdentifier("mapSwipeSegue", sender: self)
        }
    }
    
    func loadTrailName(trailId: String) {
        
        let parksURL: NSURL = [#FileReference(fileReferenceLiteral: "trailInfo.json")#]
        let parkData = NSData(contentsOfURL: parksURL)!
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(parkData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let trails = json?.objectForKey(trailId) {
                if let trailName = trails.objectForKey("trailName") as? String{
                    menuTableData.addObject("\(trailName)")
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTableData.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            pinCoordinate = CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115)
            
            let attributedStringTitle = NSAttributedString(string: "Akaka Falls Loop Trail", attributes: [
                NSFontAttributeName : UIFont.systemFontOfSize(22),
                NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                ])
            
            let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
            
            menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
            
            menuAlert.view.tintColor = UIColor.whiteColor()
            
            menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuTrailInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Park Info", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuParkInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Weather", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuWeatherSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuVRSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Directions", style: .Default, handler: { (action) -> Void in
                // Creates an instance of MKDirectionsRequest
                let request = MKDirectionsRequest()
                
                self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), addressDictionary: nil))
                
                // Defaults the transportation type as an automobile
                request.transportType = MKDirectionsTransportType.Automobile
                
                // Sets the destination
                let mapItem = self.destination
                // Sets the launch options for the native navigation app
                let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                // Launches the native navigation app
                mapItem.openInMapsWithLaunchOptions(launchOptions)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Close", style: .Destructive, handler: nil))
            
            let subview = menuAlert.view.subviews.first! as UIView
            let alertContentView = subview.subviews.first! as UIView
            alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
            
            self.presentViewController(menuAlert, animated: true, completion: nil)
            
            alertContentView.layer.cornerRadius = 12
        }
        else if indexPath.row == 2 {
            pinCoordinate = CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300)
            
            let attributedStringTitle = NSAttributedString(string: "Lava Trees Loop Trail", attributes: [
                NSFontAttributeName : UIFont.systemFontOfSize(22),
                NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                ])
            
            let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
            
            menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
            
            menuAlert.view.tintColor = UIColor.whiteColor()
            
            menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuTrailInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Park Info", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuParkInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Weather", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuWeatherSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuVRSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Directions", style: .Default, handler: { (action) -> Void in
                // Creates an instance of MKDirectionsRequest
                let request = MKDirectionsRequest()
                
                self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300), addressDictionary: nil))
                
                // Defaults the transportation type as an automobile
                request.transportType = MKDirectionsTransportType.Automobile
                
                // Sets the destination
                let mapItem = self.destination
                // Sets the launch options for the native navigation app
                let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                // Launches the native navigation app
                mapItem.openInMapsWithLaunchOptions(launchOptions)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Close", style: .Destructive, handler: nil))
            
            let subview = menuAlert.view.subviews.first! as UIView
            let alertContentView = subview.subviews.first! as UIView
            alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
            
            self.presentViewController(menuAlert, animated: true, completion: nil)
            
            alertContentView.layer.cornerRadius = 12
        }
        else if indexPath.row == 3 {
            pinCoordinate = CLLocationCoordinate2D(latitude: 19.703202, longitude: -155.079654)
            
            let attributedStringTitle = NSAttributedString(string: "College Hall Trail", attributes: [
                NSFontAttributeName : UIFont.systemFontOfSize(22),
                NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                ])
            
            let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
            
            menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
            
            menuAlert.view.tintColor = UIColor.whiteColor()
            
            menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuTrailInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Park Info", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuParkInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Weather", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuWeatherSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuVRSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Directions", style: .Default, handler: { (action) -> Void in
                // Creates an instance of MKDirectionsRequest
                let request = MKDirectionsRequest()
                
                self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.703202, longitude: -155.079654), addressDictionary: nil))
                
                // Defaults the transportation type as an automobile
                request.transportType = MKDirectionsTransportType.Automobile
                
                // Sets the destination
                let mapItem = self.destination
                // Sets the launch options for the native navigation app
                let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                // Launches the native navigation app
                mapItem.openInMapsWithLaunchOptions(launchOptions)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Close", style: .Destructive, handler: nil))
            
            let subview = menuAlert.view.subviews.first! as UIView
            let alertContentView = subview.subviews.first! as UIView
            alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
            
            self.presentViewController(menuAlert, animated: true, completion: nil)
            
            alertContentView.layer.cornerRadius = 12
        }
        else if indexPath.row == 4 {
            pinCoordinate = CLLocationCoordinate2D(latitude: 19.416333, longitude: -155.242804)
            
            let attributedStringTitle = NSAttributedString(string: "Kilauea Iki", attributes: [
                NSFontAttributeName : UIFont.systemFontOfSize(22),
                NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                ])
            
            let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
            
            menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
            
            menuAlert.view.tintColor = UIColor.whiteColor()
            
            menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuTrailInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Park Info", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuParkInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Weather", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuWeatherSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuVRSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Directions", style: .Default, handler: { (action) -> Void in
                // Creates an instance of MKDirectionsRequest
                let request = MKDirectionsRequest()
                
                self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.416333, longitude: -155.242804), addressDictionary: nil))
                
                // Defaults the transportation type as an automobile
                request.transportType = MKDirectionsTransportType.Automobile
                
                // Sets the destination
                let mapItem = self.destination
                // Sets the launch options for the native navigation app
                let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                // Launches the native navigation app
                mapItem.openInMapsWithLaunchOptions(launchOptions)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Close", style: .Destructive, handler: nil))
            
            let subview = menuAlert.view.subviews.first! as UIView
            let alertContentView = subview.subviews.first! as UIView
            alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
            
            self.presentViewController(menuAlert, animated: true, completion: nil)
            
            alertContentView.layer.cornerRadius = 12
        }
        else if indexPath.row == 5 {
            pinCoordinate = CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178)
            
            let attributedStringTitle = NSAttributedString(string: "Ala Kahakai Trail", attributes: [
                NSFontAttributeName : UIFont.systemFontOfSize(22),
                NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                ])
            
            let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .Alert)
            
            menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
            
            menuAlert.view.tintColor = UIColor.whiteColor()
            
            menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuTrailInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Park Info", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuParkInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Weather", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuWeatherSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .Default, handler: { (action) -> Void in
                self.performSegueWithIdentifier("menuVRSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Directions", style: .Default, handler: { (action) -> Void in
                // Creates an instance of MKDirectionsRequest
                let request = MKDirectionsRequest()
                
                self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178), addressDictionary: nil))
                
                // Defaults the transportation type as an automobile
                request.transportType = MKDirectionsTransportType.Automobile
                
                // Sets the destination
                let mapItem = self.destination
                // Sets the launch options for the native navigation app
                let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                // Launches the native navigation app
                mapItem.openInMapsWithLaunchOptions(launchOptions)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Close", style: .Destructive, handler: nil))
            
            let subview = menuAlert.view.subviews.first! as UIView
            let alertContentView = subview.subviews.first! as UIView
            alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
            
            self.presentViewController(menuAlert, animated: true, completion: nil)
            
            alertContentView.layer.cornerRadius = 12        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = menuTableData[indexPath.row] as? String
        
        if indexPath.row == 0 {
            //tableView.userInteractionEnabled = false
            cell.selectionStyle = .None
            
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(18)
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "menuTrailInfoSegue") {
            let svc = segue.destinationViewController as! TrailInfoController
            
            svc.toPass = pinCoordinate
        }
        if(segue.identifier == "menuParkInfoSegue") {
            let svc = segue.destinationViewController as! ParkInfoController
            
            svc.toPass = pinCoordinate
        }
        if(segue.identifier == "menuWeatherSegue") {
            let svc = segue.destinationViewController as! WeatherViewController
            
            svc.toPass = pinCoordinate
        }
    }
}
