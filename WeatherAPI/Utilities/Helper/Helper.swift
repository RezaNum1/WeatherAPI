//
//  Helper.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.
//

import Foundation
import SwiftUI
import SystemConfiguration

class Helper {
  static let shared = Helper()
  
  private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com")
  
  func unixTimeConvertion(unixTime: Double) -> String {
    let date = Date(timeIntervalSince1970: unixTime)
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "HH:mm a"
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    return dateFormatter.string(from: date)
  }
  
  func formatDateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm a"
    dateFormatter.amSymbol = "AM"
    dateFormatter.pmSymbol = "PM"
    return dateFormatter.string(from: date)
  }
  
  func checkConnection() -> Bool {
      var flags = SCNetworkReachabilityFlags()
      SCNetworkReachabilityGetFlags(reachability!, &flags)

      return isNetworkReachable(with: flags)
  }
  
  private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
      let isReachable = flags.contains(.reachable)
      let connectionRequired = flags.contains(.connectionRequired)
      let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
      let canConnectWithoutIntervention = canConnectAutomatically && !flags.contains(.interventionRequired)

      return isReachable && (!connectionRequired || canConnectWithoutIntervention)
  }
}
