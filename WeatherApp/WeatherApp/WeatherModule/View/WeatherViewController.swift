// @copyright German Autolabs Assignment

import UIKit

class WeatherViewController: UIViewController, WeatherViewInput {
    
    var output: WeatherViewOutput!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var weatherView: WeatherView!
    @IBOutlet weak var hudView: UIView!
    
    // MARK: - Actions
    @IBAction func onRecordBtn(_ sender: UIButton) {
        output.didTapOnRecord()
    }
    
    // MARK: - WeatherViewInput
    func updateRecordButton(title: String) {
        recordButton.setTitle(title, for: .normal)
    }
    
    func display(weather: WeatherViewModel) {
        weatherView.display(model: weather)
    }
    
    func displayHUD() {
        hudView.isHidden = false
    }
    
    func hideHUD() {
        hudView.isHidden = true
    }
    
    func display(message: String) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""),
                                     style: .default) { _ in
                                        alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
