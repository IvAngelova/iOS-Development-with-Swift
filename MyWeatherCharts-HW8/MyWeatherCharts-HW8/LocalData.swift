//
//  LocalData.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 23/01/2023.
//

import Foundation
import RealmSwift
import Realm

class LocalData {
    static let userDefaults = UserDefaults.standard
    
    static var latitude: String {
        set {
            userDefaults.set(newValue, forKey: "latitude")
            userDefaults.synchronize()
        }
        get {
            return userDefaults.string(forKey: "latitude") ?? "42.70"
        }
    }
    
    static var longitude: String {
        set {
            userDefaults.set(newValue, forKey: "longitude")
            userDefaults.synchronize()
        }
        get {
            return userDefaults.string(forKey: "longitude") ?? "23.32"
        }
    }
    
    static var temperatureUnit: String {
        set {
            userDefaults.set(newValue, forKey: "temperatureUnit")
            userDefaults.synchronize()
        }
        get {
            return userDefaults.string(forKey: "temperatureUnit") ?? "Celsius °C"
        }
    }
}

class LocalDataManager {
    static let realm = try! Realm(configuration: realmConfig)
    
    class func dropDatabase() {
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    static var realmConfig: Realm.Configuration {
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        config.schemaVersion = 3
        return config
    }

}

extension LocalDataManager {
    class func getWeatherData() ->  WeatherData? {
        let allWeatherData = LocalDataManager.realm.objects(WeatherData.self)
        return allWeatherData.first
    }
    
    class func allWeatherData() -> Results<WeatherData> {
        let allWeatherData = LocalDataManager.realm.objects(WeatherData.self)
        return allWeatherData
    }
}
