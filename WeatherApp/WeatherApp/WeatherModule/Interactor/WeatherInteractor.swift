// @copyright German Autolabs Assignment

final class WeatherInteractor: WeatherInteractorInput {
    
    weak var output: WeatherInteractorOutput!
    private var speechRecognizer: SpeechRecognition
    
    init(speechRecognizer: SpeechRecognition) {
        self.speechRecognizer = speechRecognizer
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
            print("\(transcription)")
        case .denied:
            print("denied")
        case .unavailable:
            print("unavailable")
        case .failure(let error):
            print("\(String(describing: error)))")
        }
    }
}
