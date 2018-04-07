// @copyright German Autolabs Assignment

import Foundation

final class TranscriptionParserImpl: TranscriptionParser {
    
    func parse(transcription: String) -> VoiceCommand? {
        
        if transcription.lowercased().contains("weather") {
            // TODO: parse city and date if any
            return .weather(city: nil, date: nil)
        }
        
        return nil
    }
}
