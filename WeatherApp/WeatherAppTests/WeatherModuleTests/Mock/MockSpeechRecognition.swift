// @copyright German Autolabs Assignment

import XCTest
@testable import WeatherApp

final class MockSpeechRecognition: SpeechRecognition {
    enum Invocation: FakeEquatable {
        case recordAndRecognize
        case stop
    }
    
    var invocations: [Invocation] = []
    
    var mockResult: SpeechRecognitionResult?
    var output: SpeechRecognitionOutput?
    func recordAndRecognize() {
        invocations.append(.recordAndRecognize)
    }
    
    func stop() {
        invocations.append(.stop)
    }
}
