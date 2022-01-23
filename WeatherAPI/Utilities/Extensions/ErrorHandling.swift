//
//  ErrorHandling.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.
//

import Foundation
import SwiftUI

enum NetworkingError: LocalizedError {
  case deviceIsOffline
  case unauthorized
  case resourceNotFound
}
