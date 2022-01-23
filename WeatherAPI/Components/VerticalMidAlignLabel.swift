//
//  VerticalLabel.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.
//

import SwiftUI

struct VerticalMidAlignLabel: View {
  var location: String
  var updateLabel: String
  
  var body: some View {
    VStack {
      Text(location)
        .withCustomTextModifier(color: .white, size: 23, weight: .semibold, design: .default)
      Text(updateLabel)
        .withCustomTextModifier(color: .white, size: 14, weight: .regular, design: .default)
    }
  }
}

struct VerticalLabel_Previews: PreviewProvider {
  static var previews: some View {
    VerticalMidAlignLabel(location: "Dhaka, BD", updateLabel: "Updated at: 18/11/2020 02:44 PM")
      .previewDevice("iPhone 12")
  }
}
