//
//  QuickViewMenuVC.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 4/12/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit
import CoreLocation




class QuickViewMenuVC: UITableViewController, UIPopoverPresentationControllerDelegate{

    var weather: NSDictionary = [:]
    var currentLocation: String = ""
    var currentTemp: String = ""
    var currentDate: String = ""
    var weatherImg: String = ""
    var weatherCur: String = ""
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    let shareData = ShareData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passedCoord = shareData.passedCoordinate
        
        var passedLat = String(passedCoord.latitude)
        var passedLon = String(passedCoord.longitude)
        
        weather = WeatherDataController().getWeather(passedLat, lon: passedLon)
        
        getCurrentWeather(weather)
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       if indexPath.row == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("weatherCell", forIndexPath: indexPath) as! QVMWeatherCell
        
            var image:UIImage?
        
            if let url = NSURL(string: "http://forecast.weather.gov/newimages/medium/\(weatherImg)") {
                if let data = NSData(contentsOfURL: url) {
                    image = UIImage(data: data)
                }
            }
        
            cell.weatherImage.image = image
            cell.currentTempLabel.text = currentTemp + "° f"
            cell.locationLabel.text = currentLocation
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("trailCell", forIndexPath: indexPath) as! QMTrailCell
        
            cell.lengthLabel.text = "2 Miles"
            cell.difficultyLabel.text = "* * * * *"
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("parkCell", forIndexPath: indexPath) as! QMParkCell
        
            cell.parkNameLabel.text = "Park Name Place Holder"
        
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("parkCell", forIndexPath: indexPath) as! QMParkCell
        
            cell.parkNameLabel.text = "Place Holder"
            return cell
        }
    }
    
    func getCurrentWeather(data: NSDictionary){
        
        do {
            if let weatherLoc = data ["location"] as? NSDictionary {
                if let areaDescription = weatherLoc["areaDescription"] as? String{
                    currentLocation = areaDescription
                }
            }
            if let currentObservations = data["currentobservation"] as? NSDictionary {
                
                if let Temp = currentObservations["Temp"] as? String{
                    currentTemp = Temp
                }
                if let Date = currentObservations["Date"] as? String{
                    currentDate = Date
                }
                if let Img = currentObservations["Weatherimage"] as? String{
                    weatherImg = Img
                }
                if let Curr = currentObservations["Weather"] as? String{
                    weatherCur = Curr
                }
            }
        } catch {
            //Throw an error if not a json or no file
            print("error serializing JSON: \(error)")
        }   
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




