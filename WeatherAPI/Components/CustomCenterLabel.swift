//
//  CustomCenterLabel.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.
//

import SwiftUI

struct CustomCenterLabel: View {
  var condition: String
  var temp: String
  var minTemp: String
  var maxTemp: String
  
  var body: some View {
    VStack {
      Text(condition)
        .withCustomTextModifier(color: .white, size: 20, weight: .semibold, design: .default)
      Text(temp)
        .withCustomTextModifier(color: .white, size: 100, weight: .thin, design: .default)
      HStack(spacing: 50) {
        HStack(spacing: 3) {
          Text("Min Temp:")
            .withCustomTextModifier(color: .white, size: 15, weight: .medium, design: .default)
          Text(minTemp)
            .withCustomTextModifier(color: .white, size: 15, weight: .medium, design: .default)
        }
        HStack(spacing: 3) {
          Text("Max Temp:")
            .withCustomTextModifier(color: .white, size: 15, weight: .medium, design: .default)
          Text(maxTemp)
            .withCustomTextModifier(color: .white, size: 15, weight: .medium, design: .default)
        }
      }
    }
  }
}

struct CustomCenterLabel_Previews: PreviewProvider {
  static var previews: some View {
    CustomCenterLabel(condition: "Haze", temp: "27", minTemp: "27", maxTemp: "27")
  }
}
