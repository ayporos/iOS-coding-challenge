// @copyright German Autolabs Assignment

import XCTest
import CoreLocation
@testable import WeatherApp

final class MockLocationService: LocationService {
    enum Invocation: FakeEquatable {
        case fetchLocation
    }
    
    var invocations: [Invocation] = []
    
    var mockResult: LocationServiceResult!
    func fetchLocation(completion: @escaping LocationServiceCompletion) {
        invocations.append(.fetchLocation)
        completion(mockResult)
    }
}
