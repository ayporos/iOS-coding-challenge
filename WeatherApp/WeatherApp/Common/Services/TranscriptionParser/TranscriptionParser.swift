// @copyright German Autolabs Assignment

import Foundation

enum VoiceCommand {
    case weather(city: String?, date: Date?)
}

protocol TranscriptionParser {
    func parse(transcription: String) -> VoiceCommand?
}
