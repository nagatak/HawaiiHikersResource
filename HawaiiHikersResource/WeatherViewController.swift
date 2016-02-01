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
    
    // Apikey
    //let openWeatherAppID = "c95098c4ab0d79ac8dafc441b786c5a4"
    //Change "Hilo"
    //var city = "Hilo"
    
    var lat : String!
    var lon : String!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lat = "19.692437"
        lon = "-155.084503"
        
        
        //Gets weather data from openweathermap.org, returns a json file.
        //Change Hilo,usa to locationManager.Lat, locationManager.Lon for weather data at current location.
        //getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=Hilo,usa&appid=8ade0e3007865a732a6e6abec729fbd4")
        //getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(city),usa&appid=\(openWeatherAppID)&units=imperial")
        
        getWeatherData("http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")
        
    }
    
    // Gets weather data
    func getWeatherData(urlString: String) {
        
        
        //let weatherURL: NSURL = NSURL(string:"http://forecast.weather.gov/MapClick.php?lat="+lat+"&lon="+lon+"&FcstType=json")!
        //let data = NSData(contentsOfURL: weatherURL)!
        
        
        // FIXME: will crash if passed a nil is unwrapped.
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
        var jsonError: NSError
        var names = [String]()
        
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