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
}
