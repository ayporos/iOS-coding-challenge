// @copyright German Autolabs Assignment

import XCTest
import CoreLocation
@testable import WeatherApp

final class WeatherEntityTests: XCTestCase {
    
    func testJSONParsing() throws {
        // given
        let path = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json")!
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        // when
        let decoder = JSONDecoder()
        let entity = try decoder.decode(OpenWeatherMapEntity.self, from: data)
        // then
        XCTAssertEqual(entity.id, 6695671)
        XCTAssertEqual(entity.name, "Sukhumvit")
        XCTAssertEqual(entity.temperature, 25.5)
        XCTAssertEqual(entity.conditions?.count, 1)
        let condition = entity.conditions?.first
        XCTAssertEqual(condition?.id, 500)
        XCTAssertEqual(condition?.description, "light rain")
        XCTAssertEqual(condition?.icon, "10d")
    }
}
