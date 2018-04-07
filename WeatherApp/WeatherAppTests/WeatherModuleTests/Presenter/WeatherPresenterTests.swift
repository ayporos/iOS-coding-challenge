// @copyright German Autolabs Assignment

import XCTest
@testable import WeatherApp

final class WeatherPresenterTests: XCTestCase {
    
    var presenter: WeatherPresenter!
    var interactor: MockWeatherInteractor!
    var view: MockWeatherView!
    
    override func setUp() {
        super.setUp()
        
        interactor = MockWeatherInteractor()
        view = MockWeatherView()
        
        presenter = WeatherPresenter()
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = WeatherRouter()
    }
    
    override func tearDown() {
        interactor = nil
        view = nil
        presenter = nil
        
        super.tearDown()
    }
    
    func testDidTapOnRecordOneTime() {
        // when
        presenter.didTapOnRecord()
        // then
        XCTAssertEqual(interactor.invocations[0], .startRecognition)
    }
    
    func testDidStartRecognition() {
        // when
        presenter.didStartRecognition()
        // then
        XCTAssertEqual(view.invocations[0], .updateRecordButton("Stop recording"))
    }
    
    func testDidFinishRecognition() {
        // when
        presenter.didFinishRecognition()
        // then
        XCTAssertEqual(view.invocations[0], .updateRecordButton("Start recording"))
    }
    
    func testDidReceiveRecognitionResultWeatherCommand() {
        // when
        presenter.didReceive(recognitionResult: .weatherCommand(city: nil, date: nil))
        // then
        XCTAssertTrue(interactor.invocations.isEmpty)
    }
    
    func testDidReceiveRecognitionResultDenied() {
        // when
        presenter.didReceive(recognitionResult: .failure(.denied))
        // then
        XCTAssertEqual(view.invocations[0],
                       .displayMessage(RecognitionError.denied.localizedDescription))
    }
    
    func testDidReceiveRecognitionResultUnrecognizedCommand() {
        // when
        presenter.didReceive(recognitionResult: .failure(.unrecognizedCommand))
        // then
        XCTAssertEqual(view.invocations[0],
                       .displayMessage(RecognitionError.unrecognizedCommand.localizedDescription))
    }
    
    func testDidReceiveRecognitionResultUnavailable() {
        // when
        presenter.didReceive(recognitionResult: .failure(.unavailable))
        // then
        XCTAssertEqual(view.invocations[0],
                       .displayMessage(RecognitionError.unavailable.localizedDescription))
    }
    
    func testDidStartWeatherFetching() {
        // when
        presenter.didStartWeatherFetching()
        // then
        XCTAssertEqual(view.invocations[0], .displayHUD)
    }
    
    func testDidFinishWeatherFetching() {
        // when
        presenter.didFinishWeatherFetching()
        // then
        XCTAssertEqual(view.invocations[0], .hideHUD)
    }

    func testDidReceiveWeatherResultSuccess() {
        // given
        let model = WeatherViewModel(name: "test",
                                     temperature: 12,
                                     description: "rain",
                                     conditionURL: nil)
        // when
        presenter.didReceive(weatherResult: .success(model))
        // then
        XCTAssertEqual(view.invocations[0], .display(model))
    }
    
    func testDidReceiveWeatherResultLocationDenied() {
        // when
        presenter.didReceive(weatherResult: .failure(.locationDenied))
        // then
        XCTAssertEqual(view.invocations[0],
                       .displayMessage(WeatherError.locationDenied.localizedDescription))
    }
    
    func testDidReceiveWeatherResultLocationUnavailable() {
        // when
        presenter.didReceive(weatherResult: .failure(.locationUnavailable))
        // then
        XCTAssertEqual(view.invocations[0],
                       .displayMessage(WeatherError.locationUnavailable.localizedDescription))
    }
}
