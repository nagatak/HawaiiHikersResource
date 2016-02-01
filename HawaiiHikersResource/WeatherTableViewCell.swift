//
//  WeatherTableViewCell.swift
//  HawaiiHikersResource
//
//  Created by Ray Manzano on 2/1/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewController
{
    //Interface builder outlets
    @IBOutlet weak var location: UILabel!
    
    // Apikey
    let openWeatherAppID = "c95098c4ab0d79ac8dafc441b786c5a4"
    //Change "Hilo"
    var city = "Hilo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gets weather data from openweathermap.org, returns a json file.
        //Change Hilo,usa to locationManager.Lat, locationManager.Lon for weather data at current location.
        //getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=Hilo,usa&appid=8ade0e3007865a732a6e6abec729fbd4")
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(city),usa&appid=\(openWeatherAppID)&units=imperial")
    }
    
    // Gets weather data
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
