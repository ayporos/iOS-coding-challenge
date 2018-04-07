// @copyright German Autolabs Assignment

import Foundation
import CoreLocation

final class OpenWeatherMapService: WeatherService {
    
    // TODO: cache weather
    private enum Constants {
        static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
        static let apiKey = "0edcad438492c1d5126e6633c6a43795"
        static let units = "metric"
    }
    
    func fetchWeather(location: CLLocation, completion: @escaping WeatherServiceCompletion) {
        let items = [URLQueryItem(name: "APPID", value: Constants.apiKey),
                     URLQueryItem(name: "units", value: Constants.units),
                     URLQueryItem(name: "lat", value: "\(location.coordinate.latitude)"),
                     URLQueryItem(name: "lon", value: "\(location.coordinate.longitude)")]
        
        var components = URLComponents(string: Constants.baseURL)
        components?.queryItems = items
        guard let queryURL = components?.url else {
            assertionFailure("Failed to construct query URL")
            completion(.failure(.unknown))
            return
        }
        
        URLSession.shared.dataTask(with: queryURL) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.api(error)))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let entity = try decoder.decode(OpenWeatherMapEntity.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(entity))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(.api(error)))
                }
            }
            }.resume()
    }
}
