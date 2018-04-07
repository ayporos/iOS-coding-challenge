// @copyright German Autolabs Assignment

protocol WeatherViewInput: class {
    
    func updateRecordButton(title: String)
    func display(weather: WeatherViewModel)
}
