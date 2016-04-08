//
//  WeatherViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//
//
import UIKit

class WeatherViewController: UITableViewController {
    
    
    @IBOutlet var locationCell: UITableView!
    @IBOutlet var weatherTable: UITableView!
    
    @IBAction func swipeClose(sender: AnyObject) {
        closeSwipe()
    }

    // Declaration of variables
    var lat : Double!
    var lon : Double!
    var tableData : NSMutableArray = []
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up design and color for tableview
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            self.tableView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            self.tableView.opaque = false
            self.tableView.backgroundView = blurEffectView
        }
        else {
            self.tableView.backgroundColor = UIColor.blackColor()
        }
        
        // Variable being passed in
        passedCoord = toPass
        
        lat = passedCoord.latitude
        lon = passedCoord.longitude

        //getWeatherData("http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")
        
        getWeather(String(lat), lon: String(lon))
    
    }
    
    // Sets data labels with retrieved weather information from JSON file
    func getWeather(lat: String, lon: String){
        //specify url for weather api
        let weatherURL: NSURL = NSURL(string:"http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")!
        let weatherData = NSData(contentsOfURL: weatherURL)!
        var forecastTime: [String] = []
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let json = json{
                
                tableData.addObject(" ")
                
                if let weatherLoc = json ["location"] as? NSDictionary {
                    if let areaDescription = weatherLoc["areaDescription"]{
                        tableData.addObject("Location: \(areaDescription)")
                    }
                }
                if let weatherTime = json ["time"] as? NSDictionary {
                    if let dayTime = weatherTime["startPeriodName"] as? NSArray{
                        
                        for index in 0 ... dayTime.count - 1{
                            forecastTime.append(dayTime[index] as! String)
                        }
                    }
                }
                if let currentObservations = json["currentobservation"] as? NSDictionary {
                    if let Temp = currentObservations["Temp"] as? String{
                        tableData.addObject("Temperature: \(Temp) degrees F.")
                    }
                    if let Date = currentObservations["Date"] as? String{
                        tableData.addObject("Date: \(Date)")
                    }
                }
                tableData.addObject("Forecast:")
                if let currentForecast = json["data"] as? NSDictionary {
                    if let forecast = currentForecast["text"] as? NSArray{
                        for index in 0 ... 5{
                            tableData.addObject("\(forecastTime[index]): \(forecast[index])")
                        }
                    }
                }
            }
        } catch {
            //Throw an error if not a json or no file
            print("error serializing JSON: \(error)")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeSwipe() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    //Set up cell design
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = NSTextAlignment.Natural
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        cell.backgroundColor = UIColor.clearColor()
        cell.backgroundView = blurEffectView
        cell.opaque = false
        cell.textLabel?.textColor = UIColor(white:0.8, alpha: 1.0)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

}