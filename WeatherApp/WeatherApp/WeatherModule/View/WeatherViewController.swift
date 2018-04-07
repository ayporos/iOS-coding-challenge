// @copyright German Autolabs Assignment

import UIKit

class WeatherViewController: UIViewController, WeatherViewInput {
    
    var output: WeatherViewOutput!
    @IBOutlet weak var recordButton: UIButton!
    
    // MARK: - Actions
    @IBAction func onRecordBtn(_ sender: UIButton) {
        output.didTapOnRecord()
    }
    
    // MARK: - WeatherViewInput
    func updateRecordButton(title: String) {
        recordButton.setTitle(title, for: .normal)
    }
}
