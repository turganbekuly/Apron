//
//  TTSMAnager.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 07.09.2022.
//

import Foundation
import AVFoundation

public class TTSMAnager {

    // MARK: - Public properties

    public static let shared = TTSMAnager()

    // MARK: - Private properties

    private let avSpeechSynthesizer = AVSpeechSynthesizer()

    // MARK: - Init

    private init() { }

    // MARK: - Methods

    public func startTTS(with text: String) {
        avSpeechSynthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: text)
        utterance.volume = 0.8
        utterance.pitchMultiplier = 1
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
        utterance.voice
        avSpeechSynthesizer.speak(utterance)
    }

    public func stopTTS() {
        avSpeechSynthesizer.stopSpeaking(at: .immediate)
    }
}
