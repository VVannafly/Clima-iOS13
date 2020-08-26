//
//  WeatherModel.swift
//  Clima
//
//  Created by Dmitriy Chernov on 26.08.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1d", temperature)
    }
    
    var conditionName: String {                     //Computed property
         switch conditionID {
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
