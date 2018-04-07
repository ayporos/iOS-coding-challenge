// @copyright German Autolabs Assignment

import UIKit

final class WeatherView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func display(model: WeatherViewModel) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        if let temperature = model.temperature {
            temperatureLabel.text = "\(temperature) °C"
        }
        if let url = model.conditionURL {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data,
                    let image = UIImage(data: data) else {
                        return
                }
                DispatchQueue.main.async {
                    self?.conditionImageView.image = image
                }
            }
            task.priority = URLSessionTask.lowPriority
            task.resume()
        }
    }
}
