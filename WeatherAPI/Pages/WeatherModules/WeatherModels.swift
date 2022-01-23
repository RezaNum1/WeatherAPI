//
//  WeatherModels.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.

import UIKit

enum Weather
{
  // MARK: Use cases
  enum Data
  {
    struct Request
    {
    }
    struct Response
    {
      let weatherModel: WeatherModel?
      let isError: Bool
      let stateMessage: String
    }
    struct ViewModel
    {
      struct WeatherCoreModel {
        var location: String
        var updatedAt: String
        var cloudCondition: String
        var temp: String
        var minTemp: String
        var maxTemp: String
        var multiLevelViews: [MultiLevelViewData]
        
        
        init(location: String = "-", updatedAt: String = "-/-/-", cloudCondition: String = "-", temp: String = "0°C", minTemp: String = "0°C", maxTemp: String = "0°C") {
          self.location = location
          self.updatedAt = updatedAt
          self.cloudCondition = cloudCondition
          self.temp = temp
          self.minTemp = minTemp
          self.maxTemp = maxTemp
          self.multiLevelViews = [
            MultiLevelViewData(iconName: "sunrise", midLabel: "Sunrise", bottomLabel: ""),
            MultiLevelViewData(iconName: "sunset", midLabel: "Sunset", bottomLabel: ""),
            MultiLevelViewData(iconName: "wind", midLabel: "Wind", bottomLabel: ""),
            MultiLevelViewData(iconName: "rectangle.compress.vertical", midLabel: "Pressure", bottomLabel: ""),
            MultiLevelViewData(iconName: "humidity", midLabel: "Humidity", bottomLabel: ""),
            MultiLevelViewData(iconName: "info.circle", midLabel: "Created by", bottomLabel: "Evan")
          ]
        }
      }
    }
  }
}

struct DetailWeather {
  let logoName: String
  let midLabel: String
  let bottomLabel: String
}

class WeatherModel: Codable {
  let coord: Coord
  let weather:[WeatherDescModel]
  let base: String
  let main: MainWeatherModel
  let visibility: Int
  let wind: Wind
  let clouds: Clouds
  let dt: Int
  let sys: Sys
  let timezone: Int
  let id: Int
  let name: String
  let cod: Int
  
  init(coord: Coord, weather: [WeatherDescModel], base: String, main: MainWeatherModel, visibility: Int, wind: Wind, clouds: Clouds, dt: Int, sys: Sys, timezone: Int, id: Int, name: String, cod: Int) {
    self.coord = coord
    self.weather = weather
    self.base = base
    self.main = main
    self.visibility = visibility
    self.wind = wind
    self.clouds = clouds
    self.dt = dt
    self.sys = sys
    self.timezone = timezone
    self.id = id
    self.name = name
    self.cod = cod
  }
}

struct Coord: Codable {
  let lon: Double
  let lat: Double
}

struct WeatherDescModel: Codable {
  let id: Int
  let main: String
  let description: String
  let icon: String
}

struct MainWeatherModel: Codable {
  let temp: Double
  let feels_like: Double
  let temp_min: Double
  let temp_max: Double
  let pressure: Int
  let humidity: Int
}

struct Wind: Codable {
  let speed: Double
  let deg: Int
}

struct Clouds: Codable {
  let all: Int
}

struct Sys: Codable {
  let type: Int
  let id: Int
  let country: String
  let sunrise: Int
  let sunset: Int
}


// MARK: - Multi level
struct MultiLevelViewData {
  let iconName: String
  let midLabel: String
  let bottomLabel: String
}
