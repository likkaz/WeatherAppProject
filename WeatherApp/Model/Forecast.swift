//
//  Forecast.swift
//  WeatherApp
//
//  Created by Lika Zurabiani on 19.02.22.
//
import UIKit

struct WeatherInfo : Codable {
    let temp: Float
    let min_temp: Float
    let max_temp: Float
    let description: String
    let icon: String
    let time: String
    let id: Int
    
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

struct ForecastTemperature : Codable {
    let weekDay: String?
    let hourlyForecast: [WeatherInfo]?
    let dt_txt: String?
}
