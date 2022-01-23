//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.

import SwiftUI

struct WeatherView: View {
  
  @ObservedObject var weatherPresenter = WeatherPresenter()
  let weatherInteractor = WeatherInteractor()
  
  init() {
    weatherInteractor.presenter = weatherPresenter
  }
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [Color.weGradientTopColor, Color.weGradientBottomColor]), startPoint: .top, endPoint: .bottom)
      ScrollView {
        VStack {
          PullToRefresh(coordinateSpaceName: PullToRefreshEnum.pullToRefresh.rawValue) {
              fetchWeatherData()
          }
          VerticalMidAlignLabel(location: weatherPresenter.weatherCoreModel.location, updateLabel: weatherPresenter.weatherCoreModel.updatedAt)
            .padding(.top, 50)
          CustomCenterLabel(condition: weatherPresenter.weatherCoreModel.cloudCondition, temp: weatherPresenter.weatherCoreModel.temp, minTemp: weatherPresenter.weatherCoreModel.minTemp, maxTemp: weatherPresenter.weatherCoreModel.maxTemp)
            .padding(.top, (UIScreen.screenHeight - 150) / 3)
          VStack {
            HStack {
              ForEach(0...2, id: \.self) { i in
                MultiLevelView(iconName: weatherPresenter.weatherCoreModel.multiLevelViews[i].iconName, midLabel: weatherPresenter.weatherCoreModel.multiLevelViews[i].midLabel, bottomLabel: weatherPresenter.weatherCoreModel.multiLevelViews[i].bottomLabel)
              }
            }
            HStack {
              ForEach(3...5, id: \.self) { i in
                MultiLevelView(iconName: weatherPresenter.weatherCoreModel.multiLevelViews[i].iconName, midLabel: weatherPresenter.weatherCoreModel.multiLevelViews[i].midLabel, bottomLabel: weatherPresenter.weatherCoreModel.multiLevelViews[i].bottomLabel)
              }
            }
          }
          .padding(.top, (UIScreen.screenHeight - 600) / 2)
        }
      }
      .coordinateSpace(name: PullToRefreshEnum.pullToRefresh.rawValue)
    }
    .alert(isPresented: $weatherPresenter.isError, content: {
      Alert(title: Text(ModalTextEnum.error.rawValue), message: Text(weatherPresenter.stateMessage), primaryButton: .destructive(Text(ModalTextEnum.tryAgain.rawValue), action: {
        weatherInteractor.fetchingWeatherData(request: Weather.Data.Request())
      }), secondaryButton: .cancel())
    })
    .edgesIgnoringSafeArea(.vertical)
    .onAppear(perform: fetchWeatherData)
  }
  
  func fetchWeatherData() {
    weatherInteractor.fetchingWeatherData(request: Weather.Data.Request())
  }
}

struct WeatherView_Preview: PreviewProvider {
  static var previews: some View {
    WeatherView()
      .previewDevice("iPhone 12")
  }
}
