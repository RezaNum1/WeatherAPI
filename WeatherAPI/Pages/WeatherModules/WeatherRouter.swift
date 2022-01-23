//
//  WeatherRouter.swift
//  WeatherAPI
//
//  Created by Reza Harris on 22/01/22.

import UIKit

@objc protocol WeatherRoutingLogic
{
}

protocol WeatherDataPassing
{
  var dataStore: WeatherDataStore? { get }
}

class WeatherRouter: NSObject, WeatherRoutingLogic, WeatherDataPassing
{
  var dataStore: WeatherDataStore?
}

// MARK: - This File Is Unused, it will used if there's a routing process in the app
