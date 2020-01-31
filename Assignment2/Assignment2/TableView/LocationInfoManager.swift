//
//  WeatherManager.swift
//  Assignment2
//
//  Created by Student on 2019-12-06.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import CoreLocation

class  LocationInfoManager{
    var cityName : String
    var countryCode : String
    
    init(){
        cityName = ""
        countryCode = ""
    }
    
    func getCityInformation(_ lat : CLLocationDegrees, _ lon : CLLocationDegrees) {
        let geoCoder = CLGeocoder()
        let cityLocation = CLLocation(latitude: lat, longitude: lon)
        geoCoder.reverseGeocodeLocation(cityLocation, completionHandler: {(placeMarks, error) -> Void in
            if error != nil {
                print("Getting location failed")
                return
            }
            if (placeMarks?.count)! > 0 {
                let pm = placeMarks?[0]
                self.cityName = (pm?.locality)!
                self.countryCode = (pm?.isoCountryCode)!
            }
        })
    }
}
