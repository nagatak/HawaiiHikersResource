//
//  WeatherTableViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 4/22/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    @IBAction func closeBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    var weather: NSDictionary = [:]
    var currentLocation: String = ""
    var currentTemp: String = ""
    var currentDate: String = ""
    var threeDayForecast: NSArray = []
    var forecastTime: [String] = []
    var weatherImg: String = ""
    var weatherCur: String = ""
    var iconLink: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weather = WeatherDataController().getWeather("19.7297", lon: "-155.0900")
        
        setWeatherData(weather)
        
        
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
        return 7
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
     
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("currentWeatherCell", forIndexPath: indexPath) as! WVCurrentWeatherCell
            var image:UIImage?
            
            if let url = NSURL(string: "http://forecast.weather.gov/newimages/medium/\(weatherImg)") {
                if let data = NSData(contentsOfURL: url) {
                    image = UIImage(data: data)
                }        
            }
            
            cell.currentWeatherImage?.image = image
            cell.currentWeatherTempLabel?.text = currentTemp
            cell.currentWeatherLocationLabel?.text = currentLocation
            cell.currentWeatherLabel?.text = weatherCur
             
            return cell
         }
        if indexPath.row > 0 || indexPath.row < 7{
            let cell = tableView.dequeueReusableCellWithIdentifier("forecastWeatherCell", forIndexPath: indexPath) as! WVForecastWeatherCell
            var image:UIImage?
            
            if let url = NSURL(string: iconLink[indexPath.row-1]) {
                if let data = NSData(contentsOfURL: url) {
                    image = UIImage(data: data)
                }
            }
            
            cell.forecastImageView?.image = image
            cell.forecastDateLabel?.text = forecastTime[indexPath.row - 1]
            cell.forecastLabel?.text = threeDayForecast[indexPath.row - 1] as? String
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("parkCell", forIndexPath: indexPath) as! QMParkCell
            
            cell.parkNameLabel.text = "Place Holder"
            return cell
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {

        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
 
    
    func setWeatherData(data: NSDictionary){
        
        do {

            if let weatherLoc = data ["location"] as? NSDictionary {
                if let areaDescription = weatherLoc["areaDescription"] as? String{
                    currentLocation = areaDescription
                }
            }
            if let weatherTime = data ["time"] as? NSDictionary {
                if let dayTime = weatherTime["startPeriodName"] as? NSArray{
                    for index in 0 ... dayTime.count - 1{
                        forecastTime.append(dayTime[index] as! String)
                    }
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
            if let currentForecast = data["data"] as? NSDictionary {
                if let forecast = currentForecast["text"] as? NSArray{
                    threeDayForecast = forecast
                }
                if let icon = currentForecast["iconLink"] as? NSArray{
                    iconLink = icon as! [String]
                }
            }
        } catch {
            //Throw an error if not a json or no file
            print("error serializing JSON: \(error)")
        }
    }

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
