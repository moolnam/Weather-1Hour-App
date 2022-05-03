//
//  ViewController.swift
//  Weather 1Hour App
//
//  Created by KimJongHee on 2022/05/03.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var weatherTextField: UITextField!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherTextField.delegate = self
        weatherManager.delegate = self
        
    }
    
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        // Weather Search Button
        weatherTextField.endEditing(true)
        // 텍스트 필드가 끝났을때 어떻게 처리할지 true
        print(weatherTextField.text!)
        weatherTextField.text = ""
        // 텍스트 필드 안에 있는 내용을 전무 지운 스트링 타입
    }
    
    
    
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(lon: lon, lat: lat)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherTextField.endEditing(true)
        // 텍스트 필드가 끝났을때 어떻게 처리할지 true
        print(weatherTextField.text!)
        weatherTextField.text = ""
        // 텍스트 필드 안에 있는 내용을 전무 지운 스트링 타입
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "again"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
            print(city)
        }
        
        weatherTextField.text = ""
    }
}

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityNameLabel.text = weather.cityName
            self.weatherIconImage.image = UIImage(systemName: weather.conditionName)
            //d
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
