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
    
    @IBAction func closeBtn(_ sender: AnyObject) {
        closeSwipe()
    }
    @IBAction func swipeClose(_ sender: AnyObject) {
        
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
    var rowH: Double = 0

    // Declaration of variables
    var lat : Double!
    var lon : Double!
    var tableData : NSMutableArray = []
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    
    let shareData = ShareData.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Variable being passed in
        passedCoord = shareData.passedCoordinate
        
        lat = passedCoord.latitude
        lon = passedCoord.longitude

        //getWeatherData("http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")
        
        getWeather(String(lat), lon: String(lon))
        
        //Set up design and color for tableview
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            //blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            self.tableView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            self.tableView.isOpaque = false
            self.tableView.backgroundView = blurEffectView
        }
        else {
            self.tableView.backgroundColor = UIColor.black
        }
    }
    
    // Sets data labels with retrieved weather information from JSON file
    func getWeather(_ lat: String, lon: String){
        //specify url for weather api
        let weatherURL: URL = URL(string:"http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")!
        let weatherData = try! Data(contentsOf: weatherURL)
        
        
        do {
            let json = try JSONSerialization.jsonObject(with: weatherData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let json = json{
                
                tableData.add(" ")
                
                if let weatherLoc = json ["location"] as? NSDictionary {
                    if let areaDescription = weatherLoc["areaDescription"]{
                        //tableData.addObject("Location: \(areaDescription)")
                        currentLocation = areaDescription as! String
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
                if let currentForecast = json["data"] as? NSDictionary {
                    if let forecast = currentForecast["text"] as? NSArray{
                        threeDayForecast = forecast
                    }
                    if let icon = currentForecast["iconLink"] as? NSArray{
                        iconLink = icon as! [String]
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
        self.dismiss(animated: true, completion: {})
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    //Set up cell design
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentWeatherCell", for: indexPath) as! WVCurrentWeatherCell
            var image:UIImage?
            
            if let url = URL(string: "http://forecast.weather.gov/newimages/medium/\(weatherImg)") {
                if let data = try? Data(contentsOf: url) {
                    image = UIImage(data: data)
                }
            }
            
            cell.currentWeatherImage?.image = image
            cell.currentWeatherTempLabel?.text = currentTemp + "° f"
            cell.currentLocationLabel?.text = currentLocation
            cell.currentWeatherLabel?.text = weatherCur
            
            return cell
        }
        if indexPath.row > 0 || indexPath.row < 7{
            let cell = tableView.dequeueReusableCell(withIdentifier: "forecastWeatherCell", for: indexPath) as! WVForecastWeatherCell
            var image:UIImage?
            
            if let url = URL(string: iconLink[indexPath.row-1]) {
                if let data = try? Data(contentsOf: url) {
                    image = UIImage(data: data)
                }
            }
            cell.forecastImageView?.image = image
            cell.forecastDateLabel?.text = forecastTime[indexPath.row - 1]
            cell.forecastLabel?.text = threeDayForecast[indexPath.row - 1] as? String

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "forecastWeatherCell", for: indexPath) as! WVForecastWeatherCell
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        let row = indexPath.row
        if row == 0{
            return 90
        }
        return 120.0
    }
    
//    func configureTableView() {
//        weatherTable.rowHeight = UITableViewAutomaticDimension
//        weatherTable.estimatedRowHeight = 160.0
//    }
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    
//    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath:
}
