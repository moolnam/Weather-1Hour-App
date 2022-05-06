//
//  WeatherManager.swift
//  Weather 1Hour App
//
//  Created by KimJongHee on 2022/05/03.
//

import Foundation
import CoreLocation
import AVFoundation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let apiKey = "27edc121638773d8a67d862806f2d6c9"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&appid=\(apiKey)&q=\(cityName)&units=metric"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func fetchWeather(lon: CLLocationDegrees, lat: CLLocationDegrees) {
        let urlString = "\(weatherURL)lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 내부에선 urlString 을 사용
        // 외부에선 with 을 사용
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    print(error!)
                }
                
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                        print(weather)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let description = decodedData.weather[0].description
            let temp = decodedData.main.temp
            let name = decodedData.name
            let lat = decodedData.coord.lat
            let lon = decodedData.coord.lon
            let tempMax = decodedData.main.temp_max
            let tempMin = decodedData.main.temp_min
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description, lon: lon, lat: lat, tempMax: tempMax, tempMin: tempMin)
            print(weather
                .temperatureString)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
