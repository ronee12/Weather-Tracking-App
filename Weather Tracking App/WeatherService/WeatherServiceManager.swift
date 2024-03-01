//
//  WeatherServiceManager.swift
//  Weather Tracking App
//
//  Created by Daraz on 1/3/24.
//

import Foundation
import CoreLocation
import ReactiveSwift




protocol WeatherServiceDelegate: AnyObject {
    func getCurrentWeatherInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> SignalProducer<WeatherModel, WeatherServiceError>
    func getWeatherInfoByCityName(cityName: String) -> SignalProducer<WeatherModel, WeatherServiceError>
    func getWeatherInfoByZipCode(zipCode: String) -> SignalProducer<WeatherModel, WeatherServiceError>
}

class WeatherServiceManager: WeatherServiceDelegate {
    let apiKey = "38ad3553ae18f39c22d38b129c0a29f0"
    var urlComponent: URLComponents
    
    init() {
        self.urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.openweathermap.org"
        urlComponent.path = "data/2.5/weather"
        urlComponent.queryItems?.append(URLQueryItem(name: "appid", value: apiKey))
    }
    
    
    func getCurrentWeatherInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> SignalProducer<WeatherModel, WeatherServiceError> {
        urlComponent.queryItems?.append(URLQueryItem(name: "lat", value: "\(latitude)"))
        urlComponent.queryItems?.append(URLQueryItem(name: "lon", value: "\(longitude)"))
        return fetchWeatherInfo(urlComponent: urlComponent)
    }
    
    func getWeatherInfoByCityName(cityName: String) -> SignalProducer<WeatherModel, WeatherServiceError> {
        urlComponent.queryItems?.append(URLQueryItem(name: "q", value: cityName))
        return fetchWeatherInfo(urlComponent: urlComponent)
    }
    
    func getWeatherInfoByZipCode(zipCode: String) -> SignalProducer<WeatherModel, WeatherServiceError> {
        urlComponent.queryItems?.append(URLQueryItem(name: "zip", value: zipCode))
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
                
                guard let weatherData = try? JSONDecoder().decode(WeatherBaseResponse.self, from: data) else {
                    return observer.send(error: .decodeError)
                }
                
                guard let weather = weatherData.weather.first else {
                    return observer.send(error: .urlParsingError)
                }
                
                let weatherModel = WeatherModel(
                    cityName: weatherData.name,
                    temperature: weatherData.main.temp,
                    title: weatherData.name,
                    describtion: weather.description,
                    iconUrl: weather.icon
                )
                return observer.send(value: weatherModel)
            }.resume()
        }
    }
}
