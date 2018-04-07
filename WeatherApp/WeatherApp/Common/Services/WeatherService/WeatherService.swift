// @copyright German Autolabs Assignment

import Foundation
import CoreLocation

enum WeatherServiceError: Error {
    case unknown
    case api(Error?)
}

extension WeatherServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Unknown error. Please try again later", comment: "")
        case .api:
            return NSLocalizedString("Service unavailable. Please try again later", comment: "")
        }
    }
}

enum WeatherServiceResult {
    // TODO: use generic weather entity instead of openmap
    case success(OpenWeatherMapEntity)
    case failure(WeatherServiceError?)
}

typealias WeatherServiceCompletion = (WeatherServiceResult) -> Void

protocol WeatherService {
    func fetchWeather(location: CLLocation, completion: @escaping WeatherServiceCompletion)
}
