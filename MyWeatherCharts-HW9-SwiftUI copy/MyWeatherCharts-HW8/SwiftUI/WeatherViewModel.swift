//
//  WeatherViewModel.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 30/01/2023.
//

import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    static let instance = WeatherViewModel()
    @Published var temperature: Double = 0.0
    @Published var windspeed: Double = 0.0
    @Published var humidity: String = ""
    @Published var pressure: String = ""
    @Published var visibility: String = ""
    @Published var lastUpdate: String = ""
    @Published var windDirection: Double = 0.0
    @Published var imageName: String = ""
    @Published var currentWeatherText: String = ""
    
    init() {
        NotificationCenter.default.addObserver(forName: .dataUpdated,
                                               object: nil,
                                               queue: OperationQueue.main,
                                               using: { [weak self] _ in
            guard let weatherData = LocalDataManager.getWeatherData() else {
                return
            }

            self?.temperature = weatherData.current_weather?.temperature ?? 0.0
            self?.windspeed = weatherData.current_weather?.windspeed ?? 0.0
            self?.lastUpdate = weatherData.lastUpdate
            self?.windDirection = weatherData.current_weather?.winddirection ?? 0.0
            self?.pressure = weatherData.pressure
            self?.humidity = weatherData.humidity
            self?.visibility = weatherData.visibility
            self?.imageName = weatherData.customizeCurrentWeather().imageName
            self?.currentWeatherText = weatherData.customizeCurrentWeather().text
        })
    }
}
