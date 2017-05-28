//
//  WVCurrentWeatherCell.swift
//  HawaiiHikersResource
//
//  Created by Kenneth Nagata on 4/22/16.
//  Copyright © 2016 Kenneth Nagata. All rights reserved.
//

import UIKit

class WVCurrentWeatherCell: UITableViewCell {

    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTempLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
