//
//  WeatherInteractor.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.

import UIKit

protocol WeatherBusinessLogic
{
  func fetchingWeatherData(request: Weather.Data.Request)
}

protocol WeatherDataStore
{
  //var name: String { get set }
}

class WeatherInteractor: WeatherBusinessLogic, WeatherDataStore
{
  var presenter: WeatherPresentationLogic?
  var worker = WeatherWorker()
  
  func fetchingWeatherData(request: Weather.Data.Request)
  {
    let network = Helper.shared.checkConnection()
    
    if let data = worker.getCachedData() {
      var response = Weather.Data.Response(weatherModel: nil, isError: false, stateMessage: "")
      if network {
        response = Weather.Data.Response(weatherModel: data, isError: false, stateMessage: "")
      } else {
        response = Weather.Data.Response(weatherModel: data, isError: true, stateMessage: "There's No Internet Connection")
      }
      
      presenter?.presentWeather(response: response)
    } else if !network && worker.getCachedData() == nil{
      let response = Weather.Data.Response(weatherModel: nil, isError: true, stateMessage: "There's No Internet Connection")
      presenter?.presentWeather(response: response)
    }
    
    if network {
      worker.fetchWeather { [weak self] result in
        switch result {
        case .success(let weather):
          let response = Weather.Data.Response(weatherModel: weather, isError: false, stateMessage: "")
          self?.presenter?.presentWeather(response: response)
        case .failure(let err):
          let response = Weather.Data.Response(weatherModel: nil, isError: true, stateMessage: err.localizedDescription)
          self?.presenter?.presentWeather(response: response)
        }
      }
    }
  }
}
