//
//  WeatherServiceManager.swift
//  Weather Tracking App
//
//  Created by Md Mehedi Hasan on 1/3/24.
//

import Foundation
import CoreLocation
import ReactiveSwift

protocol WeatherServiceDelegate: AnyObject {
    func getCurrentWeatherInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> SignalProducer<WeatherModel, WeatherServiceError>
    func getWeatherInfoByCityName(cityName: String) -> SignalProducer<WeatherModel, WeatherServiceError>
}

class WeatherServiceManager: WeatherServiceDelegate {
    let apiKey = "f37c019baf074c439d5144335210812"
    var urlComponent: URLComponents
    
    init() {
        self.urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.weatherapi.com"
        urlComponent.path = "v1/current.json"
        urlComponent.queryItems?.append(URLQueryItem(name: "key", value: apiKey))
    }
    
    
    func getCurrentWeatherInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> SignalProducer<WeatherModel, WeatherServiceError> {
        let latLong = "\(latitude),\(longitude)"
        urlComponent.queryItems?.append(URLQueryItem(name: "q", value: latLong))
        return fetchWeatherInfo(urlComponent: urlComponent)
    }
    
    func getWeatherInfoByCityName(cityName: String) -> SignalProducer<WeatherModel, WeatherServiceError> {
        urlComponent.queryItems?.append(URLQueryItem(name: "q", value: cityName))
        return fetchWeatherInfo(urlComponent: urlComponent)
    }
    
    private func fetchWeatherInfo(urlComponent: URLComponents) -> SignalProducer<WeatherModel, WeatherServiceError> {
     
        
        return SignalProducer {(observer, lifetime) in
        
            guard let url = urlComponent.url else {
                return observer.send(error: .urlParsingError)
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    return observer.send(error: .responseError(error))
                }
                
                guard let data = data else {
                    return observer.send(error: .dataNilError)
                }
                
                guard let parsedData = try? JSONDecoder().decode(WeatherBaseModel.self, from: data) else {
                    return observer.send(error: .decodeError)
                }
                
                let current = parsedData.current
                let location = parsedData.location
                
                let weatherModel = WeatherModel(cityName: location.name, temperature: current.tempC, dateTime: location.localtime, iconUrl: current.condition.icon, condition: current.condition.text)
                return observer.send(value: weatherModel)
            }.resume()
            
        }
    }
}
