//
//  WeatherInteractorTests.swift
//  WeatherAPI
//
//  Created by Reza Harris on 23/01/22.

@testable import WeatherAPI
import XCTest

class WeatherInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: WeatherInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupWeatherInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupWeatherInteractor()
  {
    sut = WeatherInteractor()
  }
  
  // MARK: Test doubles
  class WeatherPresentationLogicSpy: WeatherPresentationLogic {
    
    var weatherState = false
    
    func presentWeather(response: Weather.Data.Response) {
      
      weatherState = true
    }
  }
  
  class WeatherWorkerSpy: WeatherWorker {
    var weatherWorkerState = false
    
    override func fetchWeather(completion: @escaping (Result<WeatherModel, Error>) -> ()) {
      weatherWorkerState = true
      completion(.success(Seeds.Weather.weatherData))
    }
  }
  
  func testWeatherWorkerAndWeatherPresenter() {
    let weatherPresentationLogicSpy = WeatherPresentationLogicSpy()
    sut.presenter = weatherPresentationLogicSpy
    let weatherWorker = WeatherWorkerSpy()
    sut.worker = weatherWorker
    
    let request = Weather.Data.Request()
    sut.fetchingWeatherData(request: request)
    
    XCTAssert(weatherPresentationLogicSpy.weatherState, "Weather Presentation Logic Success")
    XCTAssert(weatherWorker.weatherWorkerState, "Weather Worker Success")
  }
}
