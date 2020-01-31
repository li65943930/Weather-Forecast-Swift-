//
//  TableViewController.swift
//  Assignment2
//
//  Created by Student on 2019-12-04.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class TableViewController: UITableViewController, CLLocationManagerDelegate{
    
    var lm = CLLocationManager()
    var weatherData = [WeatherData]()
    var locationInfoManager : LocationInfoManager = LocationInfoManager()
    var customTableViewCell : CustomTableViewCell = CustomTableViewCell()
    var jsonUrlManager : JsonUrlManager = JsonUrlManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lm.delegate = self
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        print(lat,lon)
        locationInfoManager.getCityInformation(lat, lon)
        readJsonData(lat, lon)
        print(locationInfoManager.cityName)
    }
    
    func readJsonData(_ lat : CLLocationDegrees, _ lon : CLLocationDegrees) {
        let urlString = "\(jsonUrlManager.apiUrl)/\(jsonUrlManager.apiKey)/\(lat),\(lon)?units=ca"
        let urlSession = URLSession(configuration: .default)
        
        if let url = URL(string: urlString) {
            let task = urlSession.dataTask(with: url) {
                (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let wData = try decoder.decode(ForecastData.self, from: data)
                        self.weatherData = wData.daily.data
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    catch {
                        print("Decode failed")
                    }
                }
            }
            task.resume()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ("Current City: \(locationInfoManager.cityName) \(locationInfoManager.countryCode)")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: customTableViewCell.tableViewCellIdentifier, for: indexPath) as! CustomTableViewCell
        
        fillCellInformation(cell, indexPath)
        
        return cell
    }

    func fillCellInformation(_ cell: CustomTableViewCell, _ indexPath : IndexPath) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d"
        let date = Date(timeIntervalSince1970: TimeInterval(weatherData[indexPath.row].time))
        
        cell.WeatherDescriptionLabel?.text = customTableViewCell.getWeatherDescription(for: weatherData[indexPath.row].icon)
        cell.dateLabel?.text = dateFormatter.string(from: date)
        cell.iconImage?.image = UIImage(named: weatherData[indexPath.row].icon)
        cell.temperatureHighLabel?.text = String(Int(round(self.weatherData[indexPath.row].temperatureHigh)))
        cell.temperatureLowLabel?.text =  String(Int(round(self.weatherData[indexPath.row].temperatureLow)))
    }
}
