//
//  ChartVC.swift
//  MyWeatherCharts-HW8
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 20/01/2023.
//

import UIKit
import Charts

class ChartVC: UIViewController {
    
    var weather: WeatherData?
    
    var timePeriod: [String] = []
    var temperatureArr: [Double] = []
    var relativeHumidityArr: [Double] = []
    var precipitationArr: [Double] = []

    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 5.5)
        //chartView.animate(xAxisDuration: 2.5)
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: self.view.frame.size.width,
                                     height: self.view.frame.size.width)
        lineChartView.center = view.center
        view.addSubview(lineChartView)
        lineChartView.xAxis.valueFormatter = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let weatherDataFromDB = LocalDataManager.getWeatherData()
        if weatherDataFromDB != nil {
            self.weather = weatherDataFromDB!
            self.loadingData()
        } else {
//            RequestManager.fetchDataAlamofire { result in
//                guard let weatherDataAPI = result else {
//                    return
//                }
//                self.weather = weatherDataAPI
//                self.loadingData()
//            }
            
            if let tbc = self.tabBarController as? MyCustomTabController {
                self.weather = tbc.weatherData
                self.loadingData()
            }
        }
    }
        
        private func loadingData() {
            guard let time = self.weather?.hourly?.time,
                  let temperature = self.weather?.hourly?.temperature_2m,
                  let humidity = self.weather?.hourly?.relativehumidity_2m,
                  let precipitation = self.weather?.hourly?.precipitation else {
                return
            }
            
            self.timePeriod = Array(time)
            self.temperatureArr = Array(temperature)
            self.relativeHumidityArr = Array(humidity)
            self.precipitationArr = Array(precipitation)
            
            self.setChartData()
        }
    
    private func setChartData(){
        
        var yVals1: [ChartDataEntry] = [ChartDataEntry]()
                
        for i in 0..<timePeriod.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: temperatureArr[i])
            yVals1.append(dataEntry)
        }
             
        let tempUnit: String = LocalData.temperatureUnit == "Celsius °C" ? "°C" : "°F"
        let chartDataSet1 = LineChartDataSet(entries: yVals1, label: "temperature_2m[\(tempUnit)]")
        chartDataSet1.drawCirclesEnabled = false
        chartDataSet1.setColor(.white)
        
        var yVals2: [ChartDataEntry] = [ChartDataEntry]()
                
        for i in 0..<timePeriod.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: relativeHumidityArr[i])
            yVals2.append(dataEntry)
        }
                
        let chartDataSet2 = LineChartDataSet(entries: yVals2, label: "relative_humidity_2m[%]")
        chartDataSet2.drawCirclesEnabled = false
        chartDataSet2.setColor(.red)
        
        var yVals3: [ChartDataEntry] = [ChartDataEntry]()
                
        for i in 0..<timePeriod.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: precipitationArr[i])
            yVals3.append(dataEntry)
        }
                
        let chartDataSet3 = LineChartDataSet(entries: yVals3, label: "precipitation[mm]")
        chartDataSet3.drawCirclesEnabled = false
        chartDataSet3.setColor(.green)
        
        let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2, chartDataSet3])
        self.lineChartView.data = chartData
        self.lineChartView.animate(xAxisDuration: 2.5)
    }
    
}

//extension ChartVC: ChartViewDelegate {
//    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//
//    }
//}

extension ChartVC: AxisValueFormatter {
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        return timePeriod[Int(value)]
    }

}
