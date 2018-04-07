// @copyright German Autolabs Assignment

import Foundation
import CoreLocation

final class WeatherServiceImpl: WeatherService {
    func fetchWeather(location: CLLocation, completion: @escaping WeatherServiceCompletion) {
        completion(.success)
    }
}
