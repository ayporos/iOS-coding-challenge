// @copyright German Autolabs Assignment

import XCTest
@testable import WeatherApp

final class MockWeatherInteractorOutput: WeatherInteractorOutput {
    enum Invocation: FakeEquatable {
        case didStartRecognition
        case didFinishRecognition
        case didReceiveRecognitionResult(RecognitionResult)
        case didStartWeatherFetching
        case didFinishWeatherFetching
        case didReceiveWeatherResult(WeatherResult)
    }
    
    var invocations: [Invocation] = []
    
    
    func didStartRecognition() {
        invocations.append(.didStartRecognition)
    }
    
    func didFinishRecognition() {
        invocations.append(.didFinishRecognition)
    }
    
    func didReceive(recognitionResult result: RecognitionResult) {
        invocations.append(.didReceiveRecognitionResult(result))
    }
    
    func didStartWeatherFetching() {
        invocations.append(.didStartWeatherFetching)
    }
    
    func didFinishWeatherFetching() {
        invocations.append(.didFinishWeatherFetching)
    }
    
    var error: Error?
    func didReceive(weatherResult result: WeatherResult) {
        invocations.append(.didReceiveWeatherResult(result))
        switch result {
        case .failure(let error):
            self.error = error
        default:
            break
        }
    }
}
