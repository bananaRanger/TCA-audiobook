//
//  AudioService.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 25.12.2023.
//

import AVFoundation

//MARK: Abstraction

protocol AudioServiceProtocol {
    var player: AudioPlayerProtocol? { get set }

    var duration: TimeInterval { get }
    var currentTime: TimeInterval { get set }
    var speed: AudioSpeed { get set }
    
    var onDidFinishPlaying: ((Bool) -> Void)? { get set }
    var onDecodeErrorDidOccur: ((Error?) -> Void)? { get set }
    
    func configure() throws
    
    func play(audiobook: (any AudioBook)?) throws -> Bool
    
    func pause()
    mutating func stop()
    
    mutating func moveBackword(for seconds: Double)
    mutating func moveForward(for seconds: Double)
    
    mutating func seek(to value: Double)
}

extension AudioServiceProtocol {
    var duration: TimeInterval {
        return player?.duration ?? .zero
    }
    
    var currentTime: TimeInterval {
        get { player?.currentTime ?? .zero }
        set { player?.currentTime = newValue}
    }
    
    var speed: AudioSpeed {
        get {
            let rate = player?.rate ?? .zero
            return .init(rawValue: rate) ?? ._1_0
        }
        set { player?.rate = newValue.rawValue }
    }
    
    func pause() {
        player?.pause()
    }
    
    mutating func stop() {
        player?.stop()
        player = nil
    }
    
    mutating func moveBackword(for seconds: Double) {
        var time = currentTime - seconds
        
        if time < .zero {
            time = .zero
        }
        
        currentTime = time
    }
    
    mutating func moveForward(for seconds: Double) {
        let time = currentTime + seconds
        
        if time < duration {
            currentTime = time
        }
    }
    
    mutating func seek(to value: Double) {
        currentTime = duration * value
    }
}

//MARK: Implementation

class AudioService: NSObject, AudioServiceProtocol {
    var player: AudioPlayerProtocol?
    
    var onDidFinishPlaying: ((Bool) -> Void)?
    var onDecodeErrorDidOccur: ((Error?) -> Void)?

    func configure() throws {
        try AudioPlayer.configure()
    }
    
    func play(audiobook: (any AudioBook)? = nil) throws -> Bool {
        if let player = player, !player.isPlaying {
            return player.play()
        }
        
        guard let audiobook = audiobook else {
            return false
        }
        
        let url = Bundle.main.url(
            forResource: audiobook.fileName,
            withExtension: audiobook.fileExtension
        )

        guard let url = url else {
            throw URLError(.badURL)
        }
        
        let player = try AudioPlayer(
            contentsOf: url
        )
        
        player.prepareToPlay()

        self.player = player
        
        player.delegate = self
        player.enableRate = true
        
        return player.play()
    }
}

extension AudioService: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        onDidFinishPlaying?(flag)
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        onDecodeErrorDidOccur?(error)
    }
}
