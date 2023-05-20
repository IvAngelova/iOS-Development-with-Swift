//
//  RequestManager.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 23/01/2023.
//

import Foundation
import Alamofire
import RealmSwift

class RequestManager {
    
    class func fetchDataAlamofire()//completion: @escaping (_ result: WeatherData?) -> (Void))
    {
        
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
            
            weatherData.hourly?.id = ObjectId.generate()
            weatherData.id = ObjectId.generate()
            weatherData.current_weather?.id = ObjectId.generate()
            weatherData.hourly_units?.id = ObjectId.generate()
            
            DispatchQueue.main.async {
                try? LocalDataManager.realm.write {
                    LocalDataManager.realm.delete(LocalDataManager.allWeatherData())
                }
            }
            
            DispatchQueue.main.async {
                try? LocalDataManager.realm.write {
                    LocalDataManager.realm.add(weatherData)
                }
                NotificationCenter.default.post(name: .dataUpdated, object: nil)
            }
            
//            DispatchQueue.main.async {
//                let realm = LocalDataManager.realm
//                let weatherObject = WeatherData(value: weatherData)
//                try? realm.write({
//                    realm.add(weatherObject, update: .all)
//                })
//                NotificationCenter.default.post(name: .dataUpdated, object: nil)
//            }
             //completion(weatherData)
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
