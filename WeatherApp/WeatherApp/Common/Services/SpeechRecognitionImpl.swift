// @copyright German Autolabs Assignment

import Foundation
import Speech

final class SpeechRecognitionImpl: NSObject, SpeechRecognition {
    
    private lazy var recognizer: SFSpeechRecognizer? = {
        // TODO: support other locales
        let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        recognizer?.delegate = self
        return recognizer
    }()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    func recognize(completion: @escaping SpeechRecognitionCompletion) {
        
        guard let recognizer = recognizer, recognizer.isAvailable else {
            completion(.unavailable)
            return
        }
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                do {
                    try self.record(completion)
                } catch {
                    completion(.failure(error))
                }
            case .denied, .restricted, .notDetermined:
                completion(.denied)
            }
        }
    }
}

// MARK: - SFSpeechRecognizerDelegate
extension SpeechRecognitionImpl: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if !available {
            // TODO: cancel recognition
        }
    }
}

// MARK: - Private
private extension SpeechRecognitionImpl {
    func record(_ completion: @escaping SpeechRecognitionCompletion) throws {
        // Cancel the previous task if it's running.
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        // Setup audio session for recording
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        self.recognitionRequest = recognitionRequest
        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true
        
        // A recognition task represents a speech recognition session.
        // We keep a reference to the task so that it can be cancelled.
        guard let recognizer = recognizer else { fatalError("Recording started without recognizer available") }
        recognitionTask = recognizer.recognitionTask(with: recognitionRequest) { result, error in
            // TODO:
            guard let transcription = result?.bestTranscription else { return }
            completion(.success(transcription.formattedString))
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0,
                             bufferSize: 1024,
                             format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
}
