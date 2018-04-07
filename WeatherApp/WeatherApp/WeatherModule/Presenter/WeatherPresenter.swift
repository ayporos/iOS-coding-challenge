// @copyright German Autolabs Assignment

final class WeatherPresenter: WeatherViewOutput, WeatherInteractorOutput {
    
    weak var view: WeatherViewInput!
    var interactor: WeatherInteractorInput!
    var router: WeatherRouterInput!
    
    // MARK: WeatherViewOutput
    func didTapOnRecord() {
        // TODO:
    }
    
    // MARK: WeatherInteractorOutput
}
