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
    func getCitiesBySearch(text: String) -> SignalProducer<[SearchModel], WeatherServiceError>
}

class WeatherServiceManager: WeatherServiceDelegate {
    let apiKey = "f37c019baf074c439d5144335210812"
    
    func getCurrentWeatherInfo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> SignalProducer<WeatherModel, WeatherServiceError> {
        let latLong = "\(latitude),\(longitude)"
        let urlString = "https://api.weatherapi.com/v1/current.json?q=\(latLong)&key=\(apiKey)"
        return fetchWeatherInfo(urlString: urlString)
    }
    
    func getWeatherInfoByCityName(cityName: String) -> SignalProducer<WeatherModel, WeatherServiceError> {
        let urlString = "https://api.weatherapi.com/v1/current.json?q=\(cityName)&key=\(apiKey)"
        return fetchWeatherInfo(urlString: urlString)
    }
    
    func getCitiesBySearch(text: String) -> SignalProducer<[SearchModel], WeatherServiceError> {
        
        let urlString = "https://api.weatherapi.com/v1/search.json?q=\(text)&key=\(apiKey)"
        
        return SignalProducer {(observer, lifetime) in
        
            guard let url = URL(string: urlString) else {
                return observer.send(error: .urlParsingError)
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    return observer.send(error: .responseError(error))
                }
                
                guard let data = data else {
                    return observer.send(error: .dataNilError)
                }
                
                guard let parsedData = try? JSONDecoder().decode([SearchModel].self, from: data) else {
                    return observer.send(error: .decodeError)
                }
                
                return observer.send(value: parsedData)
                
            }.resume()
            
        }
    }
    
    private func fetchWeatherInfo(urlString: String) -> SignalProducer<WeatherModel, WeatherServiceError> {
        
        return SignalProducer {(observer, lifetime) in
        
            guard let url = URL(string: urlString) else {
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
                
                let weatherModel = WeatherModel(
                    cityName: location.name,
                    temperature: current.tempC,
                    dateTime: location.localtime,
                    iconUrl: current.condition.icon,
                    condition: current.condition.text,
                    lat: location.lat,
                    long: location.lon
                )
                print("Ronee \(weatherModel)")
                return observer.send(value: weatherModel)
            }.resume()
            
        }
    }
}
