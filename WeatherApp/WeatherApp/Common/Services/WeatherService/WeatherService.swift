// @copyright German Autolabs Assignment

import Foundation
import CoreLocation

enum WeatherServiceError: Error {
    case unknown
    case api(Error?)
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
