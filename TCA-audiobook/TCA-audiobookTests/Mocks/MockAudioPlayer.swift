//
//  MockAudioPlayer.swift
//  TCA-audiobookTests
//
//  Created by Anton Yereshchenko on 19.07.2024.
//

import Foundation
import AVFAudio.AVAudioPlayer

@testable import TCA_audiobook

final class MockAudioPlayer: AudioPlayerProtocol {
    var duration: TimeInterval
    var currentTime: TimeInterval = .zero
    
    var rate: Float = 1
    var isPlaying: Bool = false
        
    static func configure() throws { }
    
    init(contentsOf url: URL) throws {
        duration = 100
    }
    
    func prepare(_ delegate: any AVAudioPlayerDelegate) { }
    
    func play() -> Bool {
        isPlaying = true
        return true
    }
    
    func pause() {
        isPlaying = false
    }
    
    func stop() {
        currentTime = .zero
        rate = 1
        isPlaying = false
    }
}
