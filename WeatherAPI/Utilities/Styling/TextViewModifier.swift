//
//  TextViewModifier.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.
//

import Foundation
import SwiftUI

struct CustomTextModifier: ViewModifier {
  let color: Color
  let size: CGFloat
  let weight: Font.Weight
  let design: Font.Design
  
  func body(content: Content) -> some View {
    let scaledSize = UIFontMetrics.default.scaledValue(for: size)
    content
      .foregroundColor(color)
      .font(.system(size: scaledSize, weight: weight, design: design))
  }
}

extension Text {
  func withCustomTextModifier(color: Color, size: CGFloat, weight: Font.Weight, design: Font.Design) -> some View {
    self.modifier(CustomTextModifier(color: color, size: size, weight: weight, design: design))
  }
}
