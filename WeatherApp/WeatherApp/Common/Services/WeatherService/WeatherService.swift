// @copyright German Autolabs Assignment

import Foundation
import CoreLocation

enum WeatherResult {
    case success
    case failure(Error?)
}

typealias WeatherServiceCompletion = (WeatherResult) -> Void

protocol WeatherService {
    func fetchWeather(location: CLLocation, completion: @escaping WeatherServiceCompletion)
}
