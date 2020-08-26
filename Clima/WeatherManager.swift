//
//  WeatherManager.swift
//  Clima
//
//  Created by Dmitriy Chernov on 24.08.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    
    var weatherCondition = " "
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?appid=868b58b4a04a0003359b9950a31afc4a&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    
    func performRequest(urlString: String) {                                        //Perfoming an URL request and recieve data
        //1. Create a URL
        
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            
            let session = URLSession(configuration: .default)
            
            //3.  Give the session a task
            let task = session.dataTask(with: url)
            {(data, response, error) in
                if error != nil {                                                   //if an error during when completing the task - return
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData)  {       //receiving the data from the URLsession task
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
                
            }
            //4.  Start the task
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {                         //performing a parsing frome early recieving data
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)      //Creating and initialising an object of WeatherModel struct
             return weather
        } catch {
            print(error)
            return nil
        }
    }
    
 
}
