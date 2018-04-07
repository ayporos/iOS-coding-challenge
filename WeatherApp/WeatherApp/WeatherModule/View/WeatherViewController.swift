// @copyright German Autolabs Assignment

import UIKit

class WeatherViewController: UIViewController, WeatherViewInput {
    
    var output: WeatherViewOutput!

    // MARK: - Actions
    @IBAction func onRecordBtn(_ sender: UIButton) {
        output.didTapOnRecord()
    }
    
    // MARK: - WeatherViewInput
}
