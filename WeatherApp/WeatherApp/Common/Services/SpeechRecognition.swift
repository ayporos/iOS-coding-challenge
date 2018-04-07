// @copyright German Autolabs Assignment

import Foundation

enum SpeechRecognitionResult {
    case success(String)
    case unavailable
    case denied
    case failure(Error?)
}

typealias SpeechRecognitionCompletion = (SpeechRecognitionResult) -> Void

protocol SpeechRecognition {
    func recognize(completion: @escaping SpeechRecognitionCompletion)
}


