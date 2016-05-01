//
//  WVForecastWeatherCell.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 4/30/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit

class WVForecastWeatherCell: UITableViewCell {
    
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var forecastDateLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
