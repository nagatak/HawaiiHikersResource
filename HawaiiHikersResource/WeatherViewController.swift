//
//  WeatherViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import UIKit

class WeatherViewController: UITableViewController {
    
    // Interface builder outlets
    /*@IBOutlet weak var locaton: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!*/
    
    @IBOutlet var locationCell: UITableView!
    
    // Declaration of variables
    var lat : Double!
    var lon : Double!
    var tableData : NSMutableArray = []
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Variable being passed in
        passedCoord = toPass
        
        lat = passedCoord.latitude
        lon = passedCoord.longitude

        //getWeatherData("http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")
        
        getWeather(String(lat), lon: String(lon))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Gets weather data
//    func getWeatherData(urlString: String) {
//
//        var url : NSURL = NSURL(string: urlString)!
//        let session = NSURLSession.sharedSession()
//        var task = session.dataTaskWithURL(url, completionHandler: {
//            (data, response, error) -> Void in
//            self.setLabels(data!)
//        })
//        
//        task.resume()
//
//    }
    
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    
        //print(tableData)
        
        cell.textLabel?.text = tableData[indexPath.row] as? String
        cell.textLabel?.numberOfLines = 0
        //cell.textLabel?.textAlignment = NSTextAlignment.Center
        //cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //cell.textLabel?.sizeToFit()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}