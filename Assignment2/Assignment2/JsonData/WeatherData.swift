//
//  WeatherData.swift
//  Assignment2
//
//  Created by Student on 2019-12-06.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

struct WeatherData : Decodable {
    let time : Int
    let temperatureHigh : Double
    let temperatureLow : Double
    let icon : String
}
