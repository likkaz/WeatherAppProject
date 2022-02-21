//
//  APIFile.swift
//  WeatherApp
//
//  Created by Lika Zurabiani on 17.02.22.
//

import Foundation

//struct weatherManager{
//
//
//    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=06f1c080d8628fe0683e0370d4a4c666&units=metric"
//
//    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
//        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
//        performRequest(with: urlString)
//    }
//
//    func performRequest(with urlString: String){
//        Alamofire.request(urlString, method: .get).responseJSON { response in
//            switch response.result{
//            case .success(let value):
//                let json = JSON(value)
//
//                debugPrint(json) //just take a peek at a raw json
//
////                if let list = json["list"]["main"].string{
////                    debugPrint(list)
//              //  }
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//
//    }
//}
//let json = "something"
//
//if let data = json.data(using: .utf8){
//    if let json = try? JSON(data: data) {
//        for item in json
//    }
//}
//
//Alamofire.request().responseJSON { (response)->Void in
//    <#code#>
//}

