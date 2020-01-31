//
//  CustomCell.swift
//  Assignment2
//
//  Created by Student on 2019-12-05.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell : UITableViewCell{
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var WeatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureHighLabel: UILabel!
    @IBOutlet weak var temperatureLowLabel: UILabel!
    
    var tableViewCellIdentifier = "WeatherCell"
    
    func getWeatherDescription(for iconText : String?) -> String? {
        switch iconText {
        case "clear-day" , "clear-night":
            return "Sunny"
        case "rain":
            return "Rain"
        case "snow":
            return "Snow"
        case "sleet":
            return "Sleet"
        case "wind":
            return "Wind"
        case "fog":
            return "Fog"
        case "cloudy":
            return  "Cloudy"
        case "partly-cloudy-day", "partly-cloudy-night":
            return "Partly Cloudy"
        default:
            print("Error in weatherDrescription")
            return ""
        }
    }
}
