//
//  Weather.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 23/01/2023.
//

import Foundation
import RealmSwift
import Realm

class CurrentWeather: Object, Codable {
    @Persisted(primaryKey: true) var id: ObjectId?
    @Persisted var temperature: Double
    @Persisted var time: String
    @Persisted var weathercode: Double
    @Persisted var winddirection: Double
    @Persisted var windspeed: Double
    
//    override class func primaryKey() -> String? {
//            return "id"
//        }
}

class Hourly: Object, Codable {
//    var time: [String]
//    var pressure_msl: [Double]
//    var visibility: [Double]
//    var relativehumidity_2m: [Double]
//    var temperature_2m: [Double]
//    var precipitation: [Double]
    
    @Persisted(primaryKey: true) var id: ObjectId?
    @Persisted var time: List<String>
    @Persisted var pressure_msl: List<Double>
    @Persisted var visibility: List<Double>
    @Persisted var relativehumidity_2m: List<Double>
    @Persisted var temperature_2m: List<Double>
    @Persisted var precipitation: List<Double>
    
//    override class func primaryKey() -> String? {
//            return "id"
//        }
    
    private enum CodingKeys: String, CodingKey {
       // case id
        case time
        case pressure_msl
        case visibility
        case relativehumidity_2m
        case temperature_2m
        case precipitation
    }
        
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //self.id = try container.decode(ObjectId.self, forKey: .id)
        let timeList = try container.decode([String].self, forKey: .time)
        time.append(objectsIn: timeList)
        let pressureList = try container.decode([Double].self, forKey: .pressure_msl)
        pressure_msl.append(objectsIn: pressureList)
        let visibilityList = try container.decode([Double].self, forKey: .visibility)
        visibility.append(objectsIn: visibilityList)
        let humidityList = try container.decode([Double].self, forKey: .relativehumidity_2m)
        relativehumidity_2m.append(objectsIn: humidityList)
        let temperatureList = try container.decode([Double].self, forKey: .temperature_2m)
        temperature_2m.append(objectsIn: temperatureList)
        let precipitationList = try container.decode([Double].self, forKey: .precipitation)
        precipitation.append(objectsIn: precipitationList)
    }
}

class HourlyUnits: Object, Codable {
    @Persisted(primaryKey: true) var id: ObjectId?
    @Persisted var time: String
    @Persisted var visibility: String
    @Persisted var relativehumidity_2m: String
    @Persisted var temperature_2m: String
    @Persisted var pressure_msl: String
    @Persisted var precipitation: String
    
//    override class func primaryKey() -> String? {
//            return "id"
//        }
}

class WeatherData: Object, Codable {
    @Persisted(primaryKey: true) var id: ObjectId?
    @Persisted var elevation: Double
    @Persisted var longitude: Double
    @Persisted var latitude: Double
    @Persisted var timezone: String
    @Persisted var timezone_abbreviation: String
    @Persisted var utc_offset_seconds: Int
    @Persisted var generationtime_ms: Double
    @Persisted var current_weather: CurrentWeather?
    @Persisted var hourly_units: HourlyUnits?
    @Persisted var hourly: Hourly?
    
//    override class func primaryKey() -> String? {
//            return "id"
//        }
    
    var lastUpdate: String {
        guard let timeLastUpdated = self.current_weather?.time.split(separator: "T").joined(separator: " ") else {
            print("problem with optional value")
            return ""
        }
        return timeLastUpdated
    }
    
    var hourlyIndex: Int {
        guard let currentTime = self.current_weather?.time else {
            print("problem with optional value")
            return -1
        }
        guard let index = self.hourly?.time.firstIndex(of: currentTime) else {
            print("problem with optional value")
            return -1
        }
        return index
    }
    
    var pressure: String {
        guard let unit = self.hourly_units?.pressure_msl else {
            print("problem with optional value")
            return "0.0"
        }
        let index = self.hourlyIndex
        if index >= 0, let value = self.hourly?.pressure_msl[index] {
            return "\(value) \(unit)"
        } else {
            print("problem with optional value")
            return "0.0 \(unit)"
        }
    }
    
    var humidity: String {
        guard let unit = self.hourly_units?.relativehumidity_2m else {
            print("problem with optional value")
            return "0.0"
        }
        let index = self.hourlyIndex
        if index >= 0, let value = self.hourly?.relativehumidity_2m[index] {
            return "\(value) \(unit)"
        } else {
            print("problem with optional value")
            return "0.0 \(unit)"
        }
    }
    
    var visibility: String {
        guard let unit = self.hourly_units?.visibility else {
            print("problem with optional value")
            return "0.0"
        }
        let index = self.hourlyIndex
        if index >= 0, let value = self.hourly?.visibility[index] {
            return "\(value) \(unit)"
        } else {
            print("problem with optional value")
            return "0.0 \(unit)"
        }
    }
}
