//
//  MultiLevelView.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.
//

import SwiftUI

struct MultiLevelView: View {
  var iconName: String
  var midLabel: String
  var bottomLabel: String
  
  var body: some View {
    VStack {
      Image(systemName: iconName)
        .resizable()
        .frame(width: 35, height: 25)
        .foregroundColor(.white)
      Text(midLabel)
        .withCustomTextModifier(color: .white, size: 12, weight: .regular, design: .default)
      Text(bottomLabel)
        .withCustomTextModifier(color: .white, size: 15, weight: .medium, design: .default)
    }
    .padding()
    .frame(width: 100, height: 80)
    .background(Color.weMultiLevelViewBackground)
  }
}

struct MultiLevelView_Previews: PreviewProvider {
  static var previews: some View {
    MultiLevelView(iconName: "sunrise", midLabel: "Sunrise", bottomLabel: "06.15 AM")
  }
}

