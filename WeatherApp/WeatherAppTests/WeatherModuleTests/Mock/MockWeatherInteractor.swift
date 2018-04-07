// @copyright German Autolabs Assignment

import XCTest
@testable import WeatherApp

final class MockWeatherInteractor: WeatherInteractorInput {
    enum Invocation: FakeEquatable {
        case startRecognition
        case stopRecognition
    }
    var invocations: [Invocation] = []
    
    func startRecognition() {
        invocations.append(.startRecognition)
    }
    
    func stopRecognition() {
        invocations.append(.stopRecognition)
    }
}
