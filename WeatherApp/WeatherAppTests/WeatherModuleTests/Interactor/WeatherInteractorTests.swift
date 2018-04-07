// @copyright German Autolabs Assignment

import XCTest
import CoreLocation
@testable import WeatherApp

final class WeatherInteractorTests: XCTestCase {
    
    var interactor: WeatherInteractor!
    var output: MockWeatherInteractorOutput!
    var speechRecognition: MockSpeechRecognition!
    var parser: MockTranscriptionParser!
    var weatherService: MockWeatherService!
    var locationService: MockLocationService!
    
    override func setUp() {
        super.setUp()
        
        speechRecognition = MockSpeechRecognition()
        parser = MockTranscriptionParser()
        weatherService = MockWeatherService()
        locationService = MockLocationService()
        interactor = WeatherInteractor(speechRecognizer: speechRecognition,
                                       parser: parser,
                                       weatherService: weatherService,
                                       locationService: locationService)
        output = MockWeatherInteractorOutput()
        interactor.output = output
    }
    
    override func tearDown() {
        interactor = nil
        output = nil
        speechRecognition = nil
        parser = nil
        weatherService = nil
        locationService = nil
        
        super.tearDown()
    }
    
    func testStartRecognition() {
        // when
        interactor.startRecognition()
        // then
        XCTAssertEqual(output.invocations[0], .didStartRecognition)
        XCTAssertEqual(speechRecognition.invocations[0], .recordAndRecognize)
    }
    
    func testStopRecognition() {
        // when
        interactor.stopRecognition()
        // then
        XCTAssertEqual(speechRecognition.invocations[0], .stop)
    }
    
    func testReceivedSpeechRecognitionResultSuccess() {
        // given
        let transcription = "test transcription"
        // when
        interactor.received(.success(transcription))
        // then
        XCTAssertEqual(output.invocations[0], .didFinishRecognition)
        XCTAssertEqual(parser.invocations[0], .parseTranscription(transcription))
    }
    
    func testReceivedSpeechRecognitionResultDenied() {
        // when
        interactor.received(.denied)
        // then
        XCTAssertEqual(output.invocations[0], .didFinishRecognition)
        XCTAssertEqual(output.invocations[1], .didReceiveRecognitionResult(.failure(.denied)))
    }
    
    func testReceivedSpeechRecognitionResultUnavailable() {
        // when
        interactor.received(.unavailable)
        // then
        XCTAssertEqual(output.invocations[0], .didFinishRecognition)
        XCTAssertEqual(output.invocations[1], .didReceiveRecognitionResult(.failure(.unavailable)))
    }
    
    func testUnrecognizedCommand() {
        // given
        parser.mockResult = nil
        // when
        interactor.received(.success("test"))
        // then
        XCTAssertEqual(output.invocations[0], .didFinishRecognition)
        XCTAssertEqual(output.invocations[1],
                       .didReceiveRecognitionResult(.failure(.unrecognizedCommand)))
    }
    
    func testReceiveWeatherLocationDenied() {
        // given
        parser.mockResult = .weather(city: nil, date: nil)
        locationService.mockResult = .denied
        // when
        interactor.received(.success("test"))
        // then
        XCTAssertEqual(output.invocations[0],
                       .didFinishRecognition)
        XCTAssertEqual(output.invocations[1],
                       .didReceiveRecognitionResult(.weatherCommand(city: nil, date: nil)))
        XCTAssertEqual(output.invocations[2],
                       .didStartWeatherFetching)
        XCTAssertEqual(output.invocations[3],
                       .didFinishWeatherFetching)
        XCTAssertEqual(output.invocations[4],
                       .didReceiveWeatherResult(.failure(.locationDenied)))
    }
    
    func testReceiveWeatherServiceError() {
        // given
        let error = NSError(domain: "test", code: 1, userInfo: nil)
        parser.mockResult = .weather(city: nil, date: nil)
        locationService.mockResult = .success(CLLocation(latitude: 10, longitude: 10))
        let apiError = WeatherServiceError.api(error)
        weatherService.mockResult = .failure(apiError)
        // when
        interactor.received(.success("test"))
        // then
        XCTAssertEqual(output.invocations[0],
                      .didFinishRecognition)
        XCTAssertEqual(output.invocations[1],
                       .didReceiveRecognitionResult(.weatherCommand(city: nil, date: nil)))
        XCTAssertEqual(output.invocations[2],
                       .didStartWeatherFetching)
        XCTAssertEqual(output.invocations[3],
                       .didFinishWeatherFetching)
        XCTAssertEqual(output.invocations[4],
                       .didReceiveWeatherResult(.failure(.unknown(apiError))))
    }
    
    func testReceiveWeatherServiceSuccess() {
        // TODO:
//        // given
//        let error = NSError(domain: "test", code: 1, userInfo: nil)
//        parser.mockResult = .weather(city: nil, date: nil)
//        locationService.mockResult = .success(CLLocation(latitude: 10, longitude: 10))
////        weatherService.mockResult = .success(weatherService
//        // when
//        interactor.received(.success("test"))
//        // then
//        XCTAssertEqual(output.invocations[0],
//                       .didFinishRecognition)
//        XCTAssertEqual(output.invocations[1],
//                       .didReceiveRecognitionResult(.weatherCommand(city: nil, date: nil)))
//        XCTAssertEqual(output.invocations[2],
//                       .didStartWeatherFetching)
//        XCTAssertEqual(output.invocations[3],
//                       .didFinishWeatherFetching)
//        XCTAssertEqual(output.invocations[4],
//                       .didReceiveWeatherResult(.failure(.unknown(apiError))))
    }
}
