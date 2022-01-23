//
//  WeatherPresenterTests.swift
//  WeatherAPI
//
//  Created by Reza Harris on 23/01/22.

@testable import WeatherAPI
import XCTest

class WeatherPresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: WeatherPresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupWeatherPresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupWeatherPresenter()
  {
    sut = WeatherPresenter()
  }
  
  class WeatherPresentationLogicSpy: WeatherPresentationLogic {
    var weatherCoreModel = Weather.Data.ViewModel.WeatherCoreModel()
    var isError = false
    var stateMessage = ""
    var presented = false
    
    func presentWeather(response: Weather.Data.Response) {
      if !response.isError {
        guard let model = response.weatherModel else {
          return
        }
        isError = response.isError
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
        
        presented = true
      } else {
        isError = true
        stateMessage = response.stateMessage
        presented = false
      }
    }
  }
  
  func testSendingAndDisplayingDataToWeatherView() {
    let weatherPresentationLogicSpy = WeatherPresentationLogicSpy()
    let response = Weather.Data.Response(weatherModel: Seeds.Weather.weatherData, isError: false, stateMessage: "")
    weatherPresentationLogicSpy.presentWeather(response: response)
    
    XCTAssert(weatherPresentationLogicSpy.presented, "Success Displaying Data")
  }
  
}
