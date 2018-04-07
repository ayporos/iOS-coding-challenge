// @copyright German Autolabs Assignment

import XCTest
import CoreLocation
@testable import WeatherApp

extension XCTestCase {
    func generateEntity() throws -> OpenWeatherMapEntity? {
        let path = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json")!
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        return try decoder.decode(OpenWeatherMapEntity.self, from: data)
    }
}
