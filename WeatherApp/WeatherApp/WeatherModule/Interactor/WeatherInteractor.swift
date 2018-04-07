// @copyright German Autolabs Assignment

final class WeatherInteractor: WeatherInteractorInput {
    
    weak var output: WeatherInteractorOutput!
    private var speechRecognizer: SpeechRecognition
    
    init(speechRecognizer: SpeechRecognition) {
        self.speechRecognizer = speechRecognizer
    }
    
    // MARK: - WeatherInteractorInput
    func recordAndRecognize() {
        speechRecognizer.recognize { result in
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
}
