//
//  WeatherModel.swift
//  Weather 1Hour App
//
//  Created by KimJongHee on 2022/05/03.
//

import Foundation
struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...711:
            return "smoke.fill"
        case 721:
            return "sun.haze.fill"
        case 731:
            return "sun.dust.fill"
        case 741...751:
            return "cloud.fog.fill"
        case 761:
            return "sun.dust.fill"
        case 762:
            return "cloud.fog.fill"
        case 771...781:
            return "tornado"
        case 800:
            return "sun.max"
        default:
            return "cloud.fill"
        }
    }
}
