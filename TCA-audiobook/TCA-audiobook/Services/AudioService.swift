//
//  AudioService.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 25.12.2023.
//

import AVFoundation

class AudioService: NSObject {
    private var player: AVAudioPlayer?
    
    var currentTime: TimeInterval {
        get { player?.currentTime ?? .zero }
        set { player?.currentTime = newValue}
    }
    
    var duration: TimeInterval {
        return player?.duration ?? .zero
    }
    
    var speed: AudioSpeed {
        let rate = player?.rate ?? .zero
        return .init(rawValue: rate) ?? ._1_0
    }
        
    var onDidFinishPlaying: ((Bool) -> Void)?
    var onDecodeErrorDidOccur: ((Error?) -> Void)?

    func configurate() throws {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
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
        
        let player = try AVAudioPlayer(
            contentsOf: url
        )
        
        player.prepareToPlay()

        self.player = player
        
        player.delegate = self
        player.enableRate = true
        
        return player.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.stop()
        player = nil
    }
    
    func moveBackword(for seconds: Double) {
        guard let player = player else { return }
        var time = player.currentTime - seconds
        
        if time < .zero {
            time = .zero
        }
        
        player.currentTime = time
    }
    
    func moveForward(for seconds: Double) {
        guard let player = player else { return }
        let time = player.currentTime + seconds
        
        if time < player.duration {
            player.currentTime = time
        }
    }
    
    func seek(to value: Double) {
        guard let player = player else { return }

        player.currentTime = player.duration * value
    }
    
    func changeSpeed(_ speed: AudioSpeed) {
        player?.rate = speed.rawValue
    }
    
    func next() {
        
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
