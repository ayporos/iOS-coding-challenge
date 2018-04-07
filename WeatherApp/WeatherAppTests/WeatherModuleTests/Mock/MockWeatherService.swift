// @copyright German Autolabs Assignment

import XCTest
import CoreLocation
@testable import WeatherApp

final class MockWeatherService: WeatherService {
    enum Invocation: FakeEquatable {
        case fetchWeatherAtLocation
    }
    
    var invocations: [Invocation] = []
    
    var mockResult: WeatherServiceResult!
    func fetchWeather(location: CLLocation,
                      completion: @escaping WeatherServiceCompletion) {
        invocations.append(.fetchWeatherAtLocation)
        completion(mockResult)
    }
}
