// @copyright German Autolabs Assignment

import Foundation

final class SpeechRecognitionImpl: SpeechRecognition {
    func recognize(completion: @escaping SpeechRecognitionCompletion) {
        completion(.success("Test"))
    }
}
