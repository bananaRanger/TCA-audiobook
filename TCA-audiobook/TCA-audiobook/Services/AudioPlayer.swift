//
//  AudioPlayer.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 19.07.2024.
//

import AVFoundation

//MARK: Abstraction

protocol AudioPlayerProtocol {
    var duration: TimeInterval { get }
    var currentTime: TimeInterval { get set }
    var rate: Float { get set }

    var isPlaying: Bool { get }
    
    static func configure() throws
    
    init(contentsOf url: URL) throws
    
    func prepare(_ delegate: AVAudioPlayerDelegate)
    
    func play() -> Bool
    func pause()
    func stop()
}

//MARK: Implementation

final class AudioPlayer: AVAudioPlayer, AudioPlayerProtocol {
    typealias Delegate = AVAudioPlayerDelegate

    static func configure() throws {
        Task {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        }
    }
        
    func prepare(_ delegate: Delegate) {
        prepareToPlay()
        
        self.delegate = delegate
        enableRate = true
    }
}
