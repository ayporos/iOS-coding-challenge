// @copyright German Autolabs Assignment

import Foundation

struct OpenWeatherMapEntity: Decodable {
    
    struct Weather: Decodable {
        
        private static let baseIconURLString = "https://openweathermap.org/img/w"
        
        var id: Int
        var description: String?
        var icon: String?
        func iconURL() -> URL? {
            guard let icon = icon else { return nil }
            return URL(string: Weather.baseIconURLString)?
                .appendingPathComponent(icon)
        }
    }
    
    var id: Int
    var name: String?
    var temperature: Double?
    var conditions: [Weather]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case conditions = "weather"
        case main
    }
    
    private enum MainCodingKeys: String, CodingKey {
        case temperature = "temp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        conditions = try container.decodeIfPresent([Weather].self, forKey: .conditions)
        let main = try container.nestedContainer(keyedBy: MainCodingKeys.self,
                                                 forKey: .main)
        temperature = try main.decodeIfPresent(Double.self, forKey: .temperature)
    }
}
