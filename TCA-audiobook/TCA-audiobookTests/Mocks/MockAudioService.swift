//
//  MockAudioService.swift
//  TCA-audiobookTests
//
//  Created by Anton Yereshchenko on 19.07.2024.
//

import Foundation

@testable import TCA_audiobook

final class MockAudioService: AudioServiceProtocol {
    var player: AudioPlayerProtocol?

    var onDidFinishPlaying: ((Bool) -> Void)?
    var onDecodeErrorDidOccur: (((any Error)?) -> Void)?
    
    func configure() throws { }
    
    func play(audiobook: (any TCA_audiobook.AudioBook)?) throws -> Bool {
        player = try MockAudioPlayer(contentsOf: .temporaryDirectory)
        return player?.play() ?? false
    }
}
