//
//  CurrentWeather.swift
//  MyWeather-HW7
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 16/01/2023.
//

import Foundation

struct CurrentWeather: Codable {
    var temperature: Double
    var time: String
    var weathercode: Double
    var winddirection: Double
    var windspeed: Double
}

//struct HourlyUnits: Codable {
//    var visibility: Double
//    var relativehumidity2m: Double
//    var pressureMsl: Double
//}

struct WeatherData: Codable {
    var elevation: Double
    var longitude: Double
    var latitude: Double
    var timezone: String
    var timezoneAbbreviation: String
    var utcOffsetSeconds: Int
    var generationtimeMs: Double
    var currentWeather: CurrentWeather
    //var hourlyUnits: HourlyUnits
}
