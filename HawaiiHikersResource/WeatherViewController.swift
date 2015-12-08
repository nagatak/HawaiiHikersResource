//
//  WeatherViewController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 11/24/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //outlets for labels in scene
    
    @IBOutlet weak var locaton: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    //apikey
    let openWeatherAppID = "c95098c4ab0d79ac8dafc441b786c5a4"
    //Change "Hilo"
    var city = "Hilo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gets weather data from openweathermap.org, returns a json file.
        //Change Hilo,usa to locationManager.Lat, locationManager.Lon for weather data at current location.
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=Hilo,usa&appid=8ade0e3007865a732a6e6abec729fbd4")
        
        //getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(city),usa&appid=\(openWeatherAppID)&units=imperial")
    }
    
    func getWeatherData(urlString: String) {
        
        // FIXME: will crash if passed a nil is unwrapped.
        var url : NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(url, completionHandler: {
            (data, response, error) -> Void in
            self.setLabels(data!)
        })
        task.resume()
        
    }
    
    func setLabels(weatherData: NSData) {
        var jsonError: NSError
        var names = [String]()
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options: .AllowFragments)
            
            if let name = json["name"] as? String {
                locationLabel.text = name
            }
            if let main = json["main"] as? NSDictionary{
                if let temp = main["temp"] as? Double {
                    tempLabel.text = String(format: "%.1f", temp)
                }
                if let humidity = main["humidity"] as? Double {
                    humidityLabel.text = String(format: "%.1f", humidity)
                }
                if let pressure = main["pressure"] as? Double {
                    pressureLabel.text = String(format: "%.1f", pressure)
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
    
    
}