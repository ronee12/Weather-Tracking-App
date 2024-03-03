//
//  LandingPageViewModel.swift
//  Weather Tracking App
//
//  Created by Md Mehedi Hasan on 1/3/24.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let dateTime: String
    let iconUrl: String
    let condition: String
    
    var temperatureString: String {
        return String(format: "%.1f° C", temperature)
    }
}

protocol LandingPageViewModelDelegate: AnyObject {
    
}

class LandingPageViewModel {
    
}
