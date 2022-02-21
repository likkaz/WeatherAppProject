//
//  forecastViewController.swift
//  WeatherApp
//
//  Created by Lika Zurabiani on 16.02.22.
//

import UIKit
import CoreLocation

class forecastViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource {
    let networkManager = WeatherNetworkManager()
    var manager: CLLocationManager?
    var forecastData: [ForecastTemperature] = []
    
    @IBOutlet var tableView : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.requestLocation()
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // forecastData = []
    }
    
    
   //MARK: Location Manager
    
    func loadLocations(lat: String, lon: String){
        networkManager.fetchNextFiveWeatherForecast(lat: lat, lon: lon) { (forecast) in
            self.forecastData = forecast
            print("Total Count:", forecast.count)
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                
                
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        
        let location = locations[0].coordinate
        loadLocations(lat: location.latitude.description,lon:location.longitude.description)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    //MARK: Table View Info
    
    func numberOfSections(in tableView: UITableView) -> Int {
        forecastData.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        forecastData[section].weekDay
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastData[section].hourlyForecast?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let dayForecast = forecastData[indexPath.section]
        guard let hourlyForecast = dayForecast.hourlyForecast
        else {
            return UITableViewCell()
        }
        cell.configure(with: hourlyForecast[indexPath.row] )
        
        
        
        return cell
    }
}

