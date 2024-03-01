//
//  WeatherModel.swift
//  Weather Tracking App
//
//  Created by Daraz on 1/3/24.
//

import Foundation

struct WeatherInfoResponse: Decodable {
    let id: Int
    let description: String
    let main: String
    let icon: String
}

struct WeatherMainResponse: Decodable {
    let temp: Double
}

struct WeatherBaseResponse: Decodable {
    let name: String
    let weather: [WeatherInfoResponse]
    let main: WeatherMainResponse
}

enum WeatherServiceError: Error, LocalizedError {
    case urlParsingError
    case responseError(Error)
    case dataNilError
    case decodeError
    
    var errorDescription: String? {
        switch self {
        case .urlParsingError:
            return "Could not parse from string to URL"
        case .responseError(let error):
            return "Data fetching is failed with error \(error.localizedDescription)"
        case .dataNilError:
            return "Fetched data is nil"
        case .decodeError:
            return "Could not parse response data"
        }
    }
}

