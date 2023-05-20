//
//  RequestManager.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 23/01/2023.
//

import Foundation
import Alamofire

class RequestManager {
    
    class func fetchDataAlamofire(completion: @escaping (_ result: WeatherData?) -> (Void)){
        
        var tempUnit: String = ""
        
        if LocalData.temperatureUnit == "Celsius °C" {
            tempUnit = ""
        } else {
            tempUnit = "&temperature_unit=fahrenheit"
        }
        
        let url: String = "https://api.open-meteo.com/v1/forecast?latitude=\(LocalData.latitude)&longitude=\(LocalData.longitude)&current_weather=true&hourly=temperature_2m,relativehumidity_2m,precipitation,visibility,pressure_msl\(tempUnit)"
        
        AF.request(url).responseDecodable(of: WeatherData.self) { response in
            guard let weatherData = response.value else {
                print("Cannot parse the data")
                return
            }
             print(weatherData)
             completion(weatherData)
        }
    }
    
//    class func fetchDataForChart(){
//        let url = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true&hourly=temperature_2m,relativehumidity_2m,precipitation,visibility,pressure_msl"
//        AF.request(url).responseString() { response in
//            guard let weatherData = response.value else {
//                return
//            }
//             print(weatherData)
//        }
//    }
}
