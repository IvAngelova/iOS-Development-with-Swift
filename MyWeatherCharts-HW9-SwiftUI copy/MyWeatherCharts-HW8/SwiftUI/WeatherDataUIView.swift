//
//  WeatherDataUIView.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 30/01/2023.
//

import SwiftUI

struct WeatherDataViewCell: View {
    var title: String
    var details: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(details)
        }
    }
}

struct WeatherDataUIView: View {
    //@State var weather: WeatherData?
    @ObservedObject var viewModel = WeatherViewModel.instance
    
    var body: some View {
        VStack {
            Spacer(minLength: 32)
            Text("Latitude: \(LocalData.latitude) Longitude: \(LocalData.longitude)").font(.system(size: 23, weight: .bold))
            Spacer(minLength: 22)
            Image(systemName: viewModel.imageName)
                .resizable()
                .frame(width: 126 , height: 96)
            Spacer(minLength: 22)
            Text(viewModel.currentWeatherText)
            Spacer(minLength: 22)
            List {
                Section("Current Weather") {
                    let tempUnit: String = LocalData.temperatureUnit == "Celsius °C" ? "°C" : "°F"
                    WeatherDataViewCell(title: "Temperature", details: "\(viewModel.temperature) \(tempUnit)")
                    WeatherDataViewCell(title: "Humidity", details: viewModel.humidity)
                    WeatherDataViewCell(title: "Pressure", details: viewModel.pressure)
                    WeatherDataViewCell(title: "Wind direction", details: "\(viewModel.windDirection) °")
                    WeatherDataViewCell(title: "Wind speed", details: "\(viewModel.windspeed) km/h")
                    WeatherDataViewCell(title: "Visibility", details: viewModel.visibility)
                    WeatherDataViewCell(title: "Last update", details: viewModel.lastUpdate)
                }
                
            }
            .background(.blue.opacity(0.0))
            .scrollContentBackground(.hidden)
        }
        .background(Color.blue.opacity(0.3))
        .onAppear {
//            if let weatherDataFromDB = LocalDataManager.getWeatherData() {
//                self.weather = weatherDataFromDB
//            } else {
                RequestManager.fetchDataAlamofire()
            //}
        }
    }
}

struct WeatherDataUIView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDataUIView()
    }
}
