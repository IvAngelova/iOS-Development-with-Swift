//
//  DataVC.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 20/01/2023.
//

import UIKit

class DataVC: UIViewController {

    var weather: WeatherData?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    @IBOutlet weak var coordinatesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.showSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let weatherDataFromDB = LocalDataManager.getWeatherData()
        if weatherDataFromDB != nil {
            self.weather = weatherDataFromDB!
            self.loadingData()
            self.removeSpinner()
        } else {
            RequestManager.fetchDataAlamofire { result in
                guard let weatherDataAPI = result else {
                    return
                }
                self.weather = weatherDataAPI
                if let tbc = self.tabBarController as? MyCustomTabController {
                    tbc.weatherData = self.weather
                }
                self.loadingData()
                self.removeSpinner()
            }
        }
        
        self.coordinatesLabel.text = "Latitude: \(LocalData.latitude) Longitude: \(LocalData.longitude)"
      
    }
    
    private func loadingData() {
        guard let weatherCode = self.weather?.current_weather?.weathercode else {
            return
        }
        
        DispatchQueue.main.async {
            let arguments = self.customizeCurrentWeather(code: weatherCode)
            self.currentWeatherLabel.text = arguments.text
            self.currentWeatherImageView.image = UIImage(systemName: arguments.imageName)
            self.tableView.reloadData()
        }
    }
    
    private func customizeCurrentWeather(code: Double) -> (text: String, imageName: String) {
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

extension DataVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        guard let weather = self.weather,
              let currentWeather = self.weather?.current_weather else {
            return cell
        }
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Temperature"
            let tempUnit: String = LocalData.temperatureUnit == "Celsius °C" ? "°C" : "°F"
            cell.detailTextLabel?.text = "\(currentWeather.temperature) \(tempUnit)"
        case 1:
            cell.textLabel?.text = "Humidity"
            cell.detailTextLabel?.text = weather.humidity
        case 2:
            cell.textLabel?.text = "Pressure"
            cell.detailTextLabel?.text = weather.pressure
        case 3:
            cell.textLabel?.text = "Wind Direction"
            cell.detailTextLabel?.text = "\(currentWeather.winddirection)°"
        case 4:
            cell.textLabel?.text = "Wind Speed"
            cell.detailTextLabel?.text = "\(currentWeather.windspeed) km/h"
        case 5:
            cell.textLabel?.text = "Visibility"
            cell.detailTextLabel?.text = weather.visibility
        case 6:
            cell.textLabel?.text = "Last Update"
            cell.detailTextLabel?.text = weather.lastUpdate
        default:
            break
        }

        return cell
    }
    
    
}
