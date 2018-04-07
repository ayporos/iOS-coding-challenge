// @copyright German Autolabs Assignment

import Foundation
import CoreLocation

final class WeatherInteractor: WeatherInteractorInput {
    
    weak var output: WeatherInteractorOutput!
    private var speechRecognizer: SpeechRecognition
    private var parser: TranscriptionParser
    private var weatherService: WeatherService
    
    init(speechRecognizer: SpeechRecognition,
         parser: TranscriptionParser,
         weatherService: WeatherService) {
        self.speechRecognizer = speechRecognizer
        self.parser = parser
        self.weatherService = weatherService
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
        case .weather(let city, let date):
            output.didReceive(recognitionResult: .weatherCommand(city: city, date: date))
            fetchWeather(city: city, date: date)
        }
    }
    
    func fetchWeather(city: String?, date: Date?) {
        
        // TODO: use city and date
        output.didStartWeatherFetching()
        let location = CLLocation(latitude: 10.1, longitude: 66.6)
        weatherService.fetchWeather(location: location) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.output.didFinishWeatherFetching()
            switch result {
            case .success:
                print("success")
            case .failure(_):
                print("error")
            }
        }
    }
}
