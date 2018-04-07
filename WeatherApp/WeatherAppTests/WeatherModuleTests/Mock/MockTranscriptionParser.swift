// @copyright German Autolabs Assignment

import XCTest
@testable import WeatherApp

final class MockTranscriptionParser: TranscriptionParser {
    enum Invocation: FakeEquatable {
        case parseTranscription(String)
    }
    
    var invocations: [Invocation] = []
    
    var mockResult: VoiceCommand?
    func parse(transcription: String) -> VoiceCommand? {
        invocations.append(.parseTranscription(transcription))
        return mockResult
    }
}

