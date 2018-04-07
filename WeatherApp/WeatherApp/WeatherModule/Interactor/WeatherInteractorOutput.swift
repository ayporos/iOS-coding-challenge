// @copyright German Autolabs Assignment

import Foundation

enum RecognitionError: Error {
    case unrecognizedCommand
    case denied
    case unavailable
    case unknown(Error?)
}

extension RecognitionError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unrecognizedCommand:
            return NSLocalizedString("We were not able to recognize your voice command. Please try again", comment: "")
        case .denied:
            return NSLocalizedString("Please enable Speech Recognition in a phone Settings", comment: "")
        case .unavailable:
            return NSLocalizedString("Speech Recognition is not supported", comment: "")
        case .unknown(let error):
            return error?.localizedDescription ??
                NSLocalizedString("Service unavailable. Please try again later", comment: "")
        }
    }
}

enum RecognitionResult {
    case weatherCommand(city: String?, date: Date?)
    case failure(RecognitionError?)
}

enum WeatherError: Error {
    case locationDenied
    case locationUnavailable
    case unknown(Error?)
}

extension WeatherError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .locationDenied:
            return NSLocalizedString("Please enable Location Services in a phone Settings", comment: "")
        case .locationUnavailable:
            return NSLocalizedString("Location Services are unavailable", comment: "")
        case .unknown(let error):
            return error?.localizedDescription ??
                NSLocalizedString("Service unavailable. Please try again later", comment: "")
        }
    }
}

enum WeatherResult {
    case success(WeatherViewModel)
    case failure(WeatherError?)
}

protocol WeatherInteractorOutput: class {
    
    // voice recognition
    func didStartRecognition()
    func didFinishRecognition()
    func didReceive(recognitionResult result: RecognitionResult)
    
    // weather fetching
    func didStartWeatherFetching()
    func didFinishWeatherFetching()
    func didReceive(weatherResult result: WeatherResult)
}
