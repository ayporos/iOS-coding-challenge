// @copyright German Autolabs Assignment

import XCTest
@testable import WeatherApp

final class MockWeatherView: WeatherViewInput {
    enum Invocation: FakeEquatable {
        case updateRecordButton(String)
        case display(WeatherViewModel)
        case displayHUD
        case hideHUD
        case displayMessage(String)
    }
    
    var invocations: [Invocation] = []
    
    func updateRecordButton(title: String) {
        invocations.append(.updateRecordButton(title))
    }
    
    func display(weather: WeatherViewModel) {
        invocations.append(.display(weather))
    }
    
    func displayHUD() {
        invocations.append(.displayHUD)
    }
    
    func hideHUD() {
        invocations.append(.hideHUD)
    }
    
    func display(message: String) {
        invocations.append(.displayMessage(message))
    }
}
