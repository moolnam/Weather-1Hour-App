//
//  WeatherData.swift
//  Weather 1Hour App
//
//  Created by KimJongHee on 2022/05/03.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
