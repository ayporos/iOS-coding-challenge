// @copyright German Autolabs Assignment

import Foundation
import CoreLocation

final class WeatherInteractor: WeatherInteractorInput {
    
    weak var output: WeatherInteractorOutput!
    private var speechRecognizer: SpeechRecognition
    private var parser: TranscriptionParser
    private var weatherService: WeatherService
    private var locationService: LocationService
    
    init(speechRecognizer: SpeechRecognition,
         parser: TranscriptionParser,
         weatherService: WeatherService,
         locationService: LocationService) {
        self.speechRecognizer = speechRecognizer
        self.parser = parser
        self.weatherService = weatherService
        self.locationService = locationService
        self.speechRecognizer.output = self
    }
    
    // MARK: - WeatherInteractorInput
    func startRecognition() {
        output.didStartRecognition()
        speechRecognizer.recordAndRecognize()
    }
    
    func stopRecognition() {
        speechRecognizer.stop()
    }
}

// MARK: - SpeechRecognitionOutput
extension WeatherInteractor: SpeechRecognitionOutput {
    func received(_ result: SpeechRecognitionResult) {
        output.didFinishRecognition()
        switch result {
        case .success(let transcription):
            parse(transcription: transcription)
        case .denied:
            output.didReceive(recognitionResult: .denied)
        case .unavailable:
            output.didReceive(recognitionResult: .unavailable)
        case .failure(let error):
            output.didReceive(recognitionResult: .failure(error))
        }
    }
    
    func parse(transcription: String) {
        guard let command = parser.parse(transcription: transcription) else {
            output.didReceive(recognitionResult: .unrecognizedCommand)
            return
        }
        
        switch command {
        case .weather(city: .none, date: .none):
            output.didReceive(recognitionResult: .weatherCommand(city: nil, date: nil))
            fetchCurrentLocationWeather()
        case .weather(let city, let date):
            output.didReceive(recognitionResult: .weatherCommand(city: city, date: date))
            fetchWeather(city: city, date: date)
        }
    }
    
    func fetchWeather(city: String?, date: Date?) {
        
        // TODO: fetch weather in the city at date
        output.didStartWeatherFetching()
    }
    
    func fetchWeather(_ location: CLLocation) {
        weatherService.fetchWeather(location: location, completion: { [weak self] result in
            switch result {
            case .success(let entity):
                let model = WeatherViewModel(name: entity.name,
                                             temperature: entity.temperature,
                                             description: entity.conditions?.first?.description,
                                             conditionURL: entity.conditions?.first?.iconURL())
                self?.output.didReceive(weatherResult: .success(model))
            case .failure(let error):
                self?.output.didReceive(weatherResult: .failure(error))
            }
        })
    }
    
    func fetchCurrentLocationWeather() {
        locationService.fetchLocation { [weak self] result in
            self?.handle(locationResult: result)
        }
    }
    
    // MARK: - Handlers
    func handle(locationResult: LocationServiceResult) {
        switch locationResult {
        case .success(let location):
            fetchWeather(location)
        case .denied:
            output.didFinishWeatherFetching()
            output.didReceive(weatherResult: .locationDenied)
        case .unavailable:
            output.didFinishWeatherFetching()
            output.didReceive(weatherResult: .locationUnavailable)
        case .failure(let error):
            output.didFinishWeatherFetching()
            output.didReceive(weatherResult: .failure(error))
        }
    }
}
