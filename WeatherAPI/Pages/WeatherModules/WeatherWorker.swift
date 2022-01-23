//
//  WeatherWorker.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.

import SwiftUI

class WeatherWorker
{
  
  let apiKey: String = "56fc2b4bc676d6260f6e02c25a64bbbe"
  let cache = NSCache<NSString, WeatherModel>()
  
  func fetchWeather(completion:@escaping (Result<WeatherModel, Error>) -> ()) {
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Jakarta&units=metric&appid=\(apiKey)") else { return }
    
    URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
      if let error = error {
        completion(.failure(NSError(domain: error.localizedDescription, code: -1, userInfo: nil)))
        return
      }
      
      guard let response = response as? HTTPURLResponse else {
        completion(.failure(NSError(domain: "Response Error", code: -1, userInfo: nil)))
        return
      }
      if response.statusCode == 200 {
        guard let data = data else {
          completion(.failure(NSError(domain: "Data Error", code: -1, userInfo: nil)))
          return
        }

        DispatchQueue.main.async {
          do {
            let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
            self?.cache.setObject(weather, forKey: "CachedWeather")
            completion(.success(weather))
          } catch {
            completion(.failure(NSError(domain: "Parsing Error", code: -1, userInfo: nil)))
          }
        }
      } else if response.statusCode == 401 {
        completion(.failure(NSError(domain: "Server Error or API Key Not Valid!", code: -1, userInfo: nil)))
      }
    }.resume()
  }
  
  func getCachedData() -> WeatherModel? {
    var weatherModel: WeatherModel? = nil
    if let cachedData = cache.object(forKey: "CachedWeather") {
      weatherModel = cachedData
    }
    
    return weatherModel
  }
}
