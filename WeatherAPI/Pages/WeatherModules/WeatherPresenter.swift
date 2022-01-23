//
//  WeatherPresenter.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.

import UIKit

protocol WeatherPresentationLogic: AnyObject
{
  func presentWeather(response: Weather.Data.Response)
}

class WeatherPresenter: WeatherPresentationLogic, ObservableObject
{
  
  @Published var weatherCoreModel = Weather.Data.ViewModel.WeatherCoreModel()
  @Published var isError: Bool = false
  @Published var stateMessage = ""
  
  func presentWeather(response: Weather.Data.Response)
  {
    if !response.isError {
      guard let model = response.weatherModel else {
        return
      }
      let location = "\(model.name), \(model.sys.country)"
      let multiLevelViews = [
        MultiLevelViewData(iconName: "sunrise", midLabel: "Sunrise", bottomLabel: Helper.shared.unixTimeConvertion(unixTime: Double(model.sys.sunrise))),
        MultiLevelViewData(iconName: "sunset", midLabel: "Sunset", bottomLabel: Helper.shared.unixTimeConvertion(unixTime: Double(model.sys.sunrise))),
        MultiLevelViewData(iconName: "wind", midLabel: "Wind", bottomLabel: "\(model.wind.speed)"),
        MultiLevelViewData(iconName: "rectangle.compress.vertical", midLabel: "Pressure", bottomLabel: "\(model.main.pressure)"),
        MultiLevelViewData(iconName: "humidity", midLabel: "Humidity", bottomLabel: "\(model.main.humidity)"),
        MultiLevelViewData(iconName: "info.circle", midLabel: "Created by", bottomLabel: "Evan")
      ]
      
      weatherCoreModel.location = location
      weatherCoreModel.temp = "\(Int(model.main.temp))°C"
      weatherCoreModel.maxTemp = "\(Int(model.main.temp_max))°C"
      weatherCoreModel.minTemp = "\(Int(model.main.temp_min))°C"
      weatherCoreModel.cloudCondition = model.weather[0].main
      weatherCoreModel.multiLevelViews = multiLevelViews
      weatherCoreModel.updatedAt = "Updated at: \(Helper.shared.formatDateToString(date: Date()))"
      isError = response.isError
    } else {
      DispatchQueue.main.async {
        self.isError = response.isError
        self.stateMessage = response.stateMessage
      }
    }
  }
}
