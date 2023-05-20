//
//  RequestManager.swift
//  MyWeather-HW7
//
//  Created by Ivy Angelova (Apprentice Mobile, eDynamix Training Programme) on 16/01/2023.
//

import Foundation

class RequestManager {
    static let urlSofia = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=42.70&longitude=23.32&current_weather=true")
    static let urlStaraZagora = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=42.43&longitude=25.64&current_weather=true")
    static let urlKazanlak = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=42.62&longitude=25.40&current_weather=true")
    
    class func fetchData(url: URL?,
                         completion: @escaping (_ result: WeatherData) -> (Void)){
        guard let url = url else {
            print("Incorrect url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            if let error = error {
                print("Get Request Error: \(error.localizedDescription)")
                return
            }
            
            // ensure there is valid response code returned from this HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                print("Invalid Response received from the server")
                return
            }
            
//            guard let payload = try? JSONSerialization.jsonObject(with: data!) as? [String: Any] else {
//                print("Cannot parse the data")
//                return
//            }
//                    print(payload)
            
            guard let data = data, let payload = try? JSONDecoder.snakeCaseDecoder.decode(WeatherData.self, from: data)
            else {
                print("Cannot parse the data")
                return
            }
            
            completion(payload)
            NotificationCenter.default.post(name: NSNotification.Name("dataRecieved"), object: nil)
            //print(payload)
        })
        task.resume()
    }
    
}
