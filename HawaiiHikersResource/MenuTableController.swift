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
    
    @IBAction func menuTable(_ sender: AnyObject) {
        let attributedStringTitle = NSAttributedString(string: "Select an Option", attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 22),
            NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            ])
        
        let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
        
        menuAlert.view.tintColor = UIColor.white
        
        menuAlert.addAction(UIAlertAction(title: "User Info", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "userInfoSegue", sender: nil)
        }))
        
        menuAlert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) -> Void in
        }))
        menuAlert.addAction(UIAlertAction(title: "Create Custom Trail", style: .default, handler: { (action) -> Void in self.performSegue(withIdentifier: "ctmMenu", sender: nil)
        }))
        
        menuAlert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
        
        let subview = menuAlert.view.subviews.first! as UIView
        let alertContentView = subview.subviews.first! as UIView
        alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
        
        self.present(menuAlert, animated: true, completion: nil)
        
        alertContentView.layer.cornerRadius = 12
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.toolbarHidden = false
        
        menuTableData.add("Trails")
        loadTrailName("akaka001")
        //passedCoord = CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115)
        loadTrailName("lavatree001")
        loadTrailName("uh")
        loadTrailName("havo001")
        loadTrailName("king001")
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MenuTableController.handleSwipes(_:)))
        
        leftSwipe.direction = .left
        
        view.addGestureRecognizer(leftSwipe)
    }
    
    func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        
        if (sender.direction == .left){
            performSegue(withIdentifier: "mapSwipeSegue", sender: self)
        }
    }
    
    func loadTrailName(_ trailId: String) {
        
        let parksURL: URL = #fileLiteral(resourceName: "trailInfo.json")
        let parkData = try! Data(contentsOf: parksURL)
        
        do {
            let json = try JSONSerialization.jsonObject(with: parkData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let trails = json?.object(forKey: trailId) {
                if let trailName = (trails as AnyObject).object(forKey: "trailName") as? String{
                    menuTableData.add("\(trailName)")
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTableData.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            pinCoordinate = CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115)
            
            let attributedStringTitle = NSAttributedString(string: "Akaka Falls Loop Trail", attributes: [
                NSFontAttributeName : UIFont.systemFont(ofSize: 22),
                NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                ])
            
            let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
            
            menuAlert.view.tintColor = UIColor.white
            
            menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuTrailInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Park Info", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuParkInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Weather", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuWeatherSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuVRSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Directions", style: .default, handler: { (action) -> Void in
                // Creates an instance of MKDirectionsRequest
                let request = MKDirectionsRequest()
                
                self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.865850, longitude: -155.116115), addressDictionary: nil))
                
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
            alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
            
            self.present(menuAlert, animated: true, completion: nil)
            
            alertContentView.layer.cornerRadius = 12
        }
        else if indexPath.row == 2 {
            pinCoordinate = CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300)
            
            let attributedStringTitle = NSAttributedString(string: "Lava Trees Loop Trail", attributes: [
                NSFontAttributeName : UIFont.systemFont(ofSize: 22),
                NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                ])
            
            let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
            
            menuAlert.view.tintColor = UIColor.white
            
            menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuTrailInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Park Info", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuParkInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Weather", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuWeatherSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuVRSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Directions", style: .default, handler: { (action) -> Void in
                // Creates an instance of MKDirectionsRequest
                let request = MKDirectionsRequest()
                
                self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.482842, longitude: -154.904300), addressDictionary: nil))
                
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
            alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
            
            self.present(menuAlert, animated: true, completion: nil)
            
            alertContentView.layer.cornerRadius = 12
        }
        else if indexPath.row == 3 {
            pinCoordinate = CLLocationCoordinate2D(latitude: 19.703202, longitude: -155.079654)
            
            let attributedStringTitle = NSAttributedString(string: "College Hall Trail", attributes: [
                NSFontAttributeName : UIFont.systemFont(ofSize: 22),
                NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                ])
            
            let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
            
            menuAlert.view.tintColor = UIColor.white
            
            menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuTrailInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Park Info", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuParkInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Weather", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuWeatherSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuVRSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Directions", style: .default, handler: { (action) -> Void in
                // Creates an instance of MKDirectionsRequest
                let request = MKDirectionsRequest()
                
                self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.703202, longitude: -155.079654), addressDictionary: nil))
                
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
            alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
            
            self.present(menuAlert, animated: true, completion: nil)
            
            alertContentView.layer.cornerRadius = 12
        }
        else if indexPath.row == 4 {
            pinCoordinate = CLLocationCoordinate2D(latitude: 19.416333, longitude: -155.242804)
            
            let attributedStringTitle = NSAttributedString(string: "Kilauea Iki", attributes: [
                NSFontAttributeName : UIFont.systemFont(ofSize: 22),
                NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                ])
            
            let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
            
            menuAlert.view.tintColor = UIColor.white
            
            menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuTrailInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Park Info", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuParkInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Weather", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuWeatherSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuVRSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Directions", style: .default, handler: { (action) -> Void in
                // Creates an instance of MKDirectionsRequest
                let request = MKDirectionsRequest()
                
                self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.416333, longitude: -155.242804), addressDictionary: nil))
                
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
            alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
            
            self.present(menuAlert, animated: true, completion: nil)
            
            alertContentView.layer.cornerRadius = 12
        }
        else if indexPath.row == 5 {
            pinCoordinate = CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178)
            
            let attributedStringTitle = NSAttributedString(string: "Ala Kahakai Trail", attributes: [
                NSFontAttributeName : UIFont.systemFont(ofSize: 22),
                NSForegroundColorAttributeName : UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
                ])
            
            let menuAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            menuAlert.setValue(attributedStringTitle, forKey: "attributedTitle")
            
            menuAlert.view.tintColor = UIColor.white
            
            menuAlert.addAction(UIAlertAction(title: "Trail Info", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuTrailInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Park Info", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuParkInfoSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Weather", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuWeatherSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "VR Preview", style: .default, handler: { (action) -> Void in
                self.performSegue(withIdentifier: "menuVRSegue", sender: nil)
            }))
            
            menuAlert.addAction(UIAlertAction(title: "Directions", style: .default, handler: { (action) -> Void in
                // Creates an instance of MKDirectionsRequest
                let request = MKDirectionsRequest()
                
                self.destination = MKMapItem(placemark:  MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.670625, longitude: -156.026178), addressDictionary: nil))
                
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
            alertContentView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
            
            self.present(menuAlert, animated: true, completion: nil)
            
            alertContentView.layer.cornerRadius = 12        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        
        cell.textLabel?.text = menuTableData[indexPath.row] as? String
        
        if indexPath.row == 0 {
            //tableView.userInteractionEnabled = false
            cell.selectionStyle = .none
            
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "menuTrailInfoSegue") {
            let svc = segue.destination as! TrailInfoController
            
            svc.toPass = pinCoordinate
        }
        if(segue.identifier == "menuParkInfoSegue") {
            let svc = segue.destination as! ParkInfoController
            
            svc.toPass = pinCoordinate
        }
        if(segue.identifier == "menuWeatherSegue") {
            let svc = segue.destination as! WeatherViewController
            
            svc.toPass = pinCoordinate
        }
    }
}
