//
//  Seeds.swift
//  WeatherAPITests
//
//  Created by Reza Harris on 23/01/22.
//

import Foundation
@testable import WeatherAPI

struct Seeds
{
  struct Weather {
    static let weatherData = WeatherModel(coord: Coord(lon:-0.1257 , lat: 51.5085), weather: [WeatherDescModel(id: 804, main: "Clouds", description: "overcastclouds", icon: "04d")], base: "stations", main: MainWeatherModel(temp: 5.93, feels_like: 3.95, temp_min: 4.6, temp_max: 7.05, pressure: 1037, humidity: 79), visibility: 10000, wind: Wind(speed: 2.57, deg: 280), clouds: Clouds(all: 100), dt: 1642866440, sys: Sys(type: 2, id: 2019646, country: "GB", sunrise: 1642837951, sunset: 1642869073), timezone: 0, id: 26437, name: "London", cod: 200)
  }
}
