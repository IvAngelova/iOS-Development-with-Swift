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
        
        NotificationCenter.default.addObserver(forName: .dataUpdated, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.loadingData()
            self?.removeSpinner()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if  let weatherDataFromDB = LocalDataManager.getWeatherData() {
//            self.weather = weatherDataFromDB
//            self.loadingData()
//            self.removeSpinner()
//        } else {
            RequestManager.fetchDataAlamofire()
//            { result in
//                guard let weatherDataAPI = result else {
//                    return
//                }
//                self.weather = weatherDataAPI
//                if let tbc = self.tabBarController as? MyCustomTabController {
//                    tbc.weatherData = self.weather
//                }
//                self.loadingData()
//                self.removeSpinner()
//            }
        //}
        
        //self.coordinatesLabel.text = "Latitude: \(LocalData.latitude) Longitude: \(LocalData.longitude)"
      
    }
    
    private func loadingData() {
        self.weather = LocalDataManager.getWeatherData()
//        guard let weatherCode = self.weather?.current_weather?.weathercode else {
//            return
//        }
        
        self.coordinatesLabel.text = "Latitude: \(LocalData.latitude) Longitude: \(LocalData.longitude)"
        
        DispatchQueue.main.async {
            self.currentWeatherLabel.text = self.weather?.customizeCurrentWeather().text
            self.currentWeatherImageView.image = UIImage(systemName: self.weather?.customizeCurrentWeather().imageName ?? "")
            self.tableView.reloadData()
        }
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
