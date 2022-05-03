//
//  ViewController.swift
//  Weather 1Hour App
//
//  Created by KimJongHee on 2022/05/03.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var weatherTextField: UITextField!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTextField.delegate = self
    }
    
    @IBAction func locationButton(_ sender: UIButton) {
        // Location Button
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        // Weather Search Button
        weatherTextField.endEditing(true)
        print(weatherTextField.text!)
        weatherTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherTextField.endEditing(true)
        print(weatherTextField.text!)
        weatherTextField.text = ""
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }


}

