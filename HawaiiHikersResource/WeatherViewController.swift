//
//  WeatherViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import UIKit

class WeatherViewController: UITableViewController {
    
    @IBOutlet weak var weatherView: UIView!
    
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
        
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            //self.view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            self.tableView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            self.tableView.opaque = false
            self.tableView.backgroundView = blurEffectView
            //self.view.addSubview(blurEffectView)
        }
        else {
            self.view.backgroundColor = UIColor.blackColor()
        }
        

        
        // Variable being passed in
        passedCoord = toPass
        
        lat = passedCoord.latitude
        lon = passedCoord.longitude

        //getWeatherData("http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")
        
        getWeather(String(lat), lon: String(lon))
        //print(String(lat), String(lon))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.weatherView.backgroundColor = UIColor.clearColor()
        
        self.view.addSubview(weatherView)
    
    
    }
    
    
    // Sets data labels with retrieved weather information from JSON file
    func getWeather(lat: String, lon: String){
        
        let weatherURL: NSURL = NSURL(string:"http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")!
        let weatherData = NSData(contentsOfURL: weatherURL)!
        
        do {

            let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let json = json{
                if let currentObservations = json["currentobservation"] as? NSDictionary {
                    if let Temp = currentObservations["Temp"] as? String{
                        //tempLabel.text = Temp
                        tableData.addObject("Temperature: \(Temp) degrees F.")
                    }
                    if let Name = currentObservations["name"] as? String{
                        //locationLabel.text = Name
                        tableData.addObject("Location: \(Name)")
                    }
                    if let Date = currentObservations["Date"] as? String{
                        print(Date)
                        tableData.addObject("Date: \(Date)")
                    }
                    if let DewPoint = currentObservations["Dewp"] as? String{
                        //humidityLabel.text = DewPoint
                        tableData.addObject("Dew Point: \(DewPoint) degrees F.")
                    }
                    if let Gust = currentObservations["Gust"] as? String{
                        print(Gust)
                        tableData.addObject("Gust: \(Gust) kt.")
                    }
                    if let Visibility = currentObservations["Visibility"] as? String{
                        print(Visibility)
                        tableData.addObject("Visibility: \(Visibility) mi.")
                    }
                    if let Winds = currentObservations["Winds"] as? String{
                        //pressureLabel.text = Winds
                        tableData.addObject("Winds: \(Winds) kt.")
                    }
                    if let Elevation = currentObservations["elev"] as? String{
                        print(Elevation)
                        tableData.addObject("Elevation: \(Elevation) ft.")
                    }
                }
                if let currentForecast = json["data"] as? NSDictionary {
                    if let forecast = currentForecast["text"] as? NSArray{
                        print(forecast[0])
                        tableData.addObject("Forecast: \(forecast[0])")
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0
        //cell.textLabel?.textAlignment = NSTextAlignment.Center
        //cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //cell.textLabel?.sizeToFit()
        
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