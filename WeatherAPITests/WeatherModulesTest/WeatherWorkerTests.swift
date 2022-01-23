//
//  WeatherWorkerTests.swift
//  WeatherAPI
//
//  Created by Reza Harris on 23/01/22.

@testable import WeatherAPI
import XCTest

class WeatherWorkerTests: XCTestCase
{
  // MARK: Subject under test

  var sut: WeatherWorker!

  // MARK: Test lifecycle

  override func setUp()
  {
    super.setUp()
    setupWeatherWorker()
  }

  override func tearDown()
  {
    super.tearDown()
  }

  // MARK: Test setup

  func setupWeatherWorker()
  {
    sut = WeatherWorker()
  }
  
  class WeatherBusinessLogicSpy: WeatherBusinessLogic {
    var fetchData = false
    
    func fetchingWeatherData(request: Weather.Data.Request) {
      fetchData = true
    }
  }
  
  func testFetchWeatherFromWorker() {
    let weatherBusinessLogicSpy = WeatherBusinessLogicSpy()
    let request = Weather.Data.Request()
    weatherBusinessLogicSpy.fetchingWeatherData(request: request)
    XCTAssert(weatherBusinessLogicSpy.fetchData, "Fetching Data Success")
  }
}
