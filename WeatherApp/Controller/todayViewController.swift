//
//  todayViewController.swift
//  WeatherApp
//
//  Created by Lika Zurabiani on 16.02.22.
//

import UIKit
import CoreLocation
import Reachability


let reachability = try! Reachability()

class todayViewController: UIViewController, CLLocationManagerDelegate{
    
    var manager: CLLocationManager?
    let networkManager = WeatherNetworkManager()
    
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //checking internet connection
        reachability.whenUnreachable = { _ in
            print("not reachable")
            self.showReachabilityAlert()
        }
        do{
            try reachability.startNotifier()
        }catch{
            print("unable to start notifier")
        }
        
        checkLocationPermission()
    }
    
    
    func showReachabilityAlert(){
        
        let alert = UIAlertController(title: "No Internet Connection", message: "This app requires internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _  in
            NSLog("The \"OK\" alert occured")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Location Manager
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        checkLocationPermission()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        
        let location = locations.first!.coordinate
        loadDataUsingCoordinates(lat: location.latitude.description,lon:location.longitude.description)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
    func showAlert(withTitle title: String?, message: String?, andActions actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default, handler: nil)]){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach({alert.addAction($0)})
        present(alert, animated: true, completion: nil)
    }
    
    
    //Checking location permisson
    func checkLocationPermission(){
        switch CLLocationManager.authorizationStatus(){
        case .notDetermined:
            manager?.requestWhenInUseAuthorization()
        case .restricted:
            showAlert(withTitle: "Error", message: "Location access was restricted")
        case .denied:
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let settingAction = UIAlertAction(title: "Settings", style: .default) { (action) in
                
                if let url = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            showAlert(withTitle: "Error", message: "Location access denied. Please allow it from Settings",
                      andActions: [settingAction, cancelAction])
        case .authorizedAlways, .authorizedWhenInUse:
            manager?.requestLocation()
        @unknown default:
            showAlert(withTitle: "Error", message: "Something went wrong")
            
            
        }
    }
    
    //MARK: Current Location Info
    func loadDataUsingCoordinates(lat: String, lon: String){
        
        networkManager.fetchCurrentLocationWeather(lat: lat, lon: lon) { (weather) in
            
            print("current Temp", weather.main.temp.kelvinToCeliusConverter())
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            //let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))

            
            
            DispatchQueue.main.async {
                self.tempLabel.text = (String(weather.main.temp.kelvinToCeliusConverter()) + "°C")
                self.locationLabel.text = "\(weather.name ?? ""), \(weather.sys.country ?? "")"
                self.humidityLabel.text = (String(weather.main.humidity) + "%")
                self.pressureLabel.text = (String(weather.main.pressure) + " hPa")
                self.speedLabel.text = (String(weather.wind.speed)+"km/h")
                self.popLabel.text = weather.weather[0].description
                self.weatherImage.image = UIImage(systemName: weather.weather[0].conditionName)
                
                
                if(weather.wind.deg > 23 && weather.wind.deg <= 67){
                    self.degreeLabel.text = "NE";
                } else if(weather.wind.deg > 68 && weather.wind.deg <= 112){
                    self.degreeLabel.text = "E";
                } else if(weather.wind.deg > 113 && weather.wind.deg <= 167){
                    self.degreeLabel.text =  "SE";
                } else if(weather.wind.deg > 168 && weather.wind.deg <= 202){
                    self.degreeLabel.text = "S";
                } else if(weather.wind.deg > 203 && weather.wind.deg <= 247){
                    self.degreeLabel.text = "SW";
                } else if(weather.wind.deg > 248 && weather.wind.deg <= 293){
                    self.degreeLabel.text =  "W";
                } else if(weather.wind.deg > 294 && weather.wind.deg <= 337){
                    self.degreeLabel.text =  "NW";
                } else if(weather.wind.deg >= 338 || weather.wind.deg <= 22){
                    self.degreeLabel.text = "N";
                } else{
                    self.degreeLabel.text = "Unknown"
                    }
                UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")
            }
        }
    }
    
    
    
    //MARK: Share Button
    
    @IBAction func shareButton(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [self.locationLabel.text! , self.tempLabel.text! , self.popLabel.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
        
        
    }
    
}

extension Float {
    func truncate(places : Int)-> Float
    {
        return Float(floor(pow(10.0, Float(places)) * self)/pow(10.0, Float(places)))
    }
    
    func kelvinToCeliusConverter() -> Float {
        let constantVal : Float = 273.15
        let kelValue = self
        let celValue = kelValue - constantVal
        return celValue.truncate(places: 1)
    }
}





