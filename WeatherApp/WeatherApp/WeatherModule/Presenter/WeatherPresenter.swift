// @copyright German Autolabs Assignment

final class WeatherPresenter: WeatherViewOutput, WeatherInteractorOutput {
    
    weak var view: WeatherViewInput!
    var interactor: WeatherInteractorInput!
    var router: WeatherRouterInput!
    private var isRecording = false
    
    // MARK: WeatherViewOutput
    func didTapOnRecord() {
        if isRecording {
            interactor.stopRecognition()
        } else {
            interactor.startRecognition()
        }
    }
    
    // MARK: WeatherInteractorOutput
    func didStartRecognition() {
        isRecording = true
        view.updateRecordButton(title: "Stop recording")
    }
    
    func didFinishRecognition() {
        isRecording = false
        view.updateRecordButton(title: "Start recording")
    }
    
    func didReceive(recognitionResult result: RecognitionResult) {
        switch result {
        case .weatherCommand(_, _):
            print("weather command recognized")
        case .unrecognizedCommand:
            print("weather command not recognized")
        case .denied:
            print("denied")
        case .unavailable:
            print("unavailable")
        case .failure(let error):
            print("\(String(describing: error))")
        }
    }
    
    func didStartWeatherFetching() {
        
    }
    
    func didFinishWeatherFetching() {
        
    }
    
    func didReceive(weatherResult result: FetchWeatherResult) {
        
    }
}
