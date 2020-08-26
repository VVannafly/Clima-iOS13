//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {  //action while pressing go button on the keyboard
        searchPressed(textField)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { //action before end editing but after pressing the button
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type a city"
            return false
        }
    }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            if let city = searchTextField.text {
                weatherManager.fetchWeather(cityName: city)
            }
            //Use searchTextField.text to get the weather for taht city
            searchTextField.text = ""
        }
    
    
    func didUpdateWeather( weather: WeatherModel) {
        print(weather.temperature)
    }
}

