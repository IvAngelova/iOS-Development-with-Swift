//
//  KazanlakVC.swift
//  MyWeather-HW7
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 16/01/2023.
//

import UIKit

class KazanlakVC: UIViewController {
    
    var stringDict: [String: String] = [:]
    var map: [String: Any] = [:] {
        didSet {
                self.stringDict = self.map.compactMapValues { "\($0)" }
        }
    }

    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("dataRecieved"), object: nil, queue: OperationQueue.main) { _ in
            self.reloadDataOnScreen()
        }
        self.dataTableView.dataSource = self
        self.dataTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.currentWeatherLabel.text = "Loading..."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        RequestManager.fetchData(url: RequestManager.urlKazanlak, completion: {result in
            let weatherCode = result.currentWeather.weathercode
            DispatchQueue.main.async {
                let arguments = WeatherCode.instance.customizeCurrentWeather(code: weatherCode)
                self.currentWeatherLabel.text = arguments.text
                self.currentWeatherImageView.image = UIImage(systemName: arguments.imageName)
            }
            
            self.map["Temperature in °C"] = result.currentWeather.temperature
            self.map["Last updated"] = result.currentWeather.time
            self.map["Wind speed in km/h"] = result.currentWeather.windspeed
            self.map["Wind direction in °"] = result.currentWeather.winddirection
        })
    }
    
    func reloadDataOnScreen() {
        dataTableView.reloadData()
    }

}

extension KazanlakVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stringDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        guard stringDict.count > indexPath.row else {
            return cell
        }

        let key = Array(stringDict)[indexPath.row].key
        cell.textLabel?.text = key
        let value = stringDict[key]
        cell.detailTextLabel?.text = value
        
        return cell
    }
    
}
