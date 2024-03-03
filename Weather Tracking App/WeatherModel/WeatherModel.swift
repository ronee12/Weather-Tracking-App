//
//  WeatherModel.swift
//  Weather Tracking App
//
//  Created by Md Mehedi Hasan on 1/3/24.
//

import Foundation

struct WeatherBaseModel: Decodable {
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Decodable {
    let tempC: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
    }
}

// MARK: - Condition
struct Condition: Decodable {
    let text, icon: String
    let code: Int
}

// MARK: - Location
struct Location: Decodable {
    let name, country: String
    let localtime: String
}

// MARK: - Weather Errors
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

