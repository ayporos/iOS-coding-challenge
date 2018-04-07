// @copyright German Autolabs Assignment

import Foundation

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
            break
        case .failure(let error):
            if let message = error?.localizedDescription {
                view.display(message: message)
            }
        }
    }
    
    func didStartWeatherFetching() {
        view.displayHUD()
    }
    
    func didFinishWeatherFetching() {
        view.hideHUD()
    }
    
    func didReceive(weatherResult result: WeatherResult) {
        switch result {
        case .success(let model):
            view.display(weather: model)
        case .failure(let error):
            if let message = error?.localizedDescription {
                view.display(message: message)
            }
        }
    }
}
