// @copyright German Autolabs Assignment

import Foundation

enum SpeechRecognitionResult {
    case success(String)
    case unavailable
    case denied
    case failure(Error?)
}

typealias SpeechRecognitionCompletion = (SpeechRecognitionResult) -> Void

protocol SpeechRecognitionOutput: class {
    func received(_ result: SpeechRecognitionResult)
}

protocol SpeechRecognition {
    var output: SpeechRecognitionOutput? { get set }
    func recordAndRecognize()
    func stop()
}


