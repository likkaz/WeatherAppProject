//
//  NetworkManagerProtocol.swift
//  WeatherApp
//
//  Created by Lika Zurabiani on 19.02.22.
//

import UIKit
import CoreLocation

protocol NetworkManagerProtocol {
    func fetchCurrentLocationWeather(lat: String, lon: String, completion: @escaping (WeatherModel) -> ())
    func fetchNextFiveWeatherForecast(lat: String, lon: String, completion: @escaping ([ForecastTemperature]) -> ())
}
