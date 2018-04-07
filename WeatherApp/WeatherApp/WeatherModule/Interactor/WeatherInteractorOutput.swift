// @copyright German Autolabs Assignment

import Foundation

enum RecognitionResult {
    case weatherCommand(city: String?, date: Date?)
    case unrecognizedCommand
    case denied
    case unavailable
    case failure(Error?)
}

protocol WeatherInteractorOutput: class {
    
    // voice recognition
    func didStartRecognition()
    func didFinishRecognition()
    func didReceive(recognitionResult result: RecognitionResult)
    
    // weather fetching
    func didStartWeatherFetching()
    func didFinishWeatherFetching()
}
