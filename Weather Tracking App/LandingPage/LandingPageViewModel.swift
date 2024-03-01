//
//  LandingPageViewModel.swift
//  Weather Tracking App
//
//  Created by Daraz on 1/3/24.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let title: String
    let describtion: String
    let iconUrl: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
}

protocol LandingPageViewModelDelegate: AnyObject {
    
}

class LandingPageViewModel {
    
}
