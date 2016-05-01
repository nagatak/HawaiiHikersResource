//
//  WeatherDataController.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 4/22/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherDataController {
    
    var lat : Double!
    var lon : Double!
    var toPass: CLLocationCoordinate2D!
    var passedCoord: CLLocationCoordinate2D!
    
    var weatherLocation: String = ""
 
    // Get weather Data
    func getWeather(lat: String, lon: String) -> NSDictionary{
        //specify url for weather api
        let weatherURL: NSURL = NSURL(string:"http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")!
        let weatherData = NSData(contentsOfURL: weatherURL)!
        var wD: NSDictionary = [:]
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            if let json = json{
                wD = json
            }
        } catch {
            //Throw an error if not a json or no file
            print("error serializing JSON: \(error)")
        }
        
        return wD
    }
}
