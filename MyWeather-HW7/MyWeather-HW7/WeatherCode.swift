//
//  WeatherCode.swift
//  MyWeather-HW7
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 16/01/2023.
//

import Foundation

class WeatherCode {
    static let instance = WeatherCode()
    
    func customizeCurrentWeather(code: Double) -> (text: String, imageName: String) {
        var text: String = ""
        var imageName: String = ""
        switch code {
        case 0.0:
            text = "Clear sky"
            imageName = "cloud.sun"
        case 1.0, 2.0, 3.0:
            text = "Cloudy"
            imageName = "cloud"
        case 45.0, 48.0:
            text = "Fog"
            imageName = "cloud.fog"
        case 51.0, 53.0, 55.0, 56.0, 57.0:
            text = "Drizzle"
            imageName = "cloud.drizzle"
        case 61.0, 63.0, 65.0, 66.0, 67.0:
            text = "Rain"
            imageName = "cloud.rain"
        case 71.0, 73.0, 75.0, 77.0:
            text = "Snow fall"
            imageName = "cloud.snow"
        case 80.0, 81.0, 82.0:
            text = "Rain showers"
            imageName = "cloud.rain"
        case 85.0, 86.0:
            text = "Snow showers"
            imageName = "cloud.snow"
        case 95.0, 96.0, 99.0:
            text = "Thunderstorm"
            imageName = "cloud.bolt.rain"
        default:
            break
        }
        return (text, imageName)
    }
}
