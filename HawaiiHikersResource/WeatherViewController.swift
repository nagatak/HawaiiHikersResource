//
//  WeatherViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // Interface builder outlets
    @IBOutlet weak var locaton: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    var lat : String!
    var lon : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lat = "19.692437"
        lon = "-155.084503"

        getWeatherData("http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")
        
    }
    
    // Gets weather data
    func getWeatherData(urlString: String) {

        var url : NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(url, completionHandler: {
            (data, response, error) -> Void in
            self.setLabels(data!)
        })
        
        task.resume()

    }
    
    // Sets data labels with retrieved weather information from JSON file
    func setLabels(weatherData: NSData) {

        do {

            let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let json = json{
                if let currentObservations = json["currentobservation"] as? NSDictionary {
                    if let Temp = currentObservations["Temp"] as? String{
                        print(Temp)
                    }
                    if let Name = currentObservations["name"] as? String{
                        print(Name)
                    }
                    if let Date = currentObservations["Date"] as? String{
                        print(Date)
                    }
                    if let DewPoint = currentObservations["Dewp"] as? String{
                        print(DewPoint)
                    }
                    if let Gust = currentObservations["Gust"] as? String{
                        print(Gust)
                    }
                    if let Visibility = currentObservations["Visibiity"] as? String{
                        print(Visibility)
                    }
                    if let Winds = currentObservations["Winds"] as? String{
                        print(Winds)
                    }
                    if let Elevation = currentObservations["elev"] as? String{
                        print(Elevation)
                    }
                }
                if let currentForecast = json["data"] as? NSDictionary {
                    if let forecast = currentForecast["text"] as? NSArray{
                        print(forecast[0])
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
    
    
}