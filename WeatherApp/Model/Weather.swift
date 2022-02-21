//
//  Weather.swift
//  WeatherApp
//
//  Created by Lika Zurabiani on 19.02.22.
//

import UIKit

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    
    
    var conditionName: String {
        switch id{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

struct Main: Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Float
    let humidity: Float
    
}

struct Sys: Codable {
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}

struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Main
    let sys: Sys
    let name: String?
    let dt: Int
    let timezone: Int?
    let dt_txt: String?
    let wind: Wind
}

struct ForecastModel: Codable {
    var list: [WeatherModel]
   // let city: City
}

struct City: Codable {
 //   let name: String?
    let country: String?
    
}

struct Wind: Codable {
    let speed : Float
    let deg: Float
    
    
}


