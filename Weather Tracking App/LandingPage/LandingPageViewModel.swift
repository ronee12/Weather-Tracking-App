//
//  LandingPageViewModel.swift
//  Weather Tracking App
//
//  Created by Md Mehedi Hasan on 1/3/24.
//

import Foundation
import ReactiveSwift

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

class LandingPageViewModel {
    let weatherService: WeatherServiceDelegate
    let cityModel = MutableProperty<[SearchModelResponse]>([])
    let weatherInfo = MutableProperty<WeatherModel?>(nil)
    init(weatherService: WeatherServiceDelegate) {
        self.weatherService = weatherService
    }
    
    func getCities(text: String) {
        weatherService.getCitiesBySearch(text: text).startWithResult { [weak self] result in
            switch result {
            case .success(let value):
                self?.cityModel.value = value
            case .failure(let error):
                print("API failed to get cities name error: \(error.localizedDescription)")
                self?.cityModel.value = []
            }
        }
    }
    
    func getWeatherByLatLon(lat: Double, lon: Double) {
        weatherService.getCurrentWeatherInfo(latitude: lat, longitude: lon).startWithResult { [weak self] result in
            switch result {
            case .success(let value):
                self?.weatherInfo.value = value
            case .failure(let error):
                print("API failed to get weather info by lat long error: \(error.localizedDescription)")
                self?.weatherInfo.value = nil
            }
        }
    }
    
    func getWeatherByCityName(cityName: String) {
        weatherService.getWeatherInfoByCityName(cityName: cityName).startWithResult { [weak self] result in
            switch result {
            case .success(let value):
                self?.weatherInfo.value = value
            case .failure(let error):
                print("API failed to get weather info by city name error: \(error.localizedDescription)")
                self?.weatherInfo.value = nil
            }
        }
    }
}

extension LandingPageViewModel {
    
    var numberOfRows: Int {
        return cityModel.value.count
    }
    
    func getSearchModel(indexPath: IndexPath)-> SearchModelResponse? {
        if(indexPath.row < cityModel.value.count) {
            return cityModel.value[indexPath.row]
        } else {
            return nil
        }
    }
}
