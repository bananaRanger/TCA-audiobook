//
//  AudioServiceTests.swift
//  TCA-audiobookTests
//
//  Created by Anton Yereshchenko on 19.07.2024.
//

import XCTest

@testable import TCA_audiobook

final class AudioServiceTests: XCTestCase {
    
    var audioService: AudioServiceProtocol!
    var isStartedPlay: Bool!
    
    override func setUpWithError() throws {
        audioService = MockAudioService()
        isStartedPlay = try audioService.play(
            audiobook: MockAudioBook.vanityFair
        )
    }

    override func tearDownWithError() throws {
        audioService.stop()
    }

    func testAudioPause() throws {
        XCTAssertEqual(isStartedPlay, true)
        
        XCTAssertEqual(audioService.player?.isPlaying, true)
        audioService.pause()
        XCTAssertEqual(audioService.player?.isPlaying, false)
    }
    
    func testAudioStop() throws {
        XCTAssertEqual(isStartedPlay, true)
        
        XCTAssertEqual(audioService.player?.isPlaying, true)
        audioService.stop()
        XCTAssertEqual(audioService.player?.isPlaying, nil)
    }
    
    func testAudioSpeedChanging() throws {
        XCTAssertEqual(isStartedPlay, true)
        
        XCTAssertEqual(audioService.speed, ._1_0)
        audioService.speed = ._2_0
        XCTAssertEqual(audioService.speed, ._2_0)
    }
    
    func testAudioDuration() throws {
        XCTAssertEqual(isStartedPlay, true)
        
        XCTAssertEqual(audioService.duration, 100)
    }
    
    func testAudioSeeking() throws {
        XCTAssertEqual(isStartedPlay, true)
        
        XCTAssertEqual(audioService.currentTime, 0)
        audioService.seek(to: 0.5)
        XCTAssertEqual(audioService.currentTime, 50)
    }
    
    func testAudioMoveForward() throws {
        XCTAssertEqual(isStartedPlay, true)
        
        XCTAssertEqual(audioService.currentTime, 0)
        audioService.moveForward(for: 5)
        XCTAssertEqual(audioService.currentTime, 5)
    }
    
    func testAudioMoveBackword() throws {
        XCTAssertEqual(isStartedPlay, true)
        
        XCTAssertEqual(audioService.currentTime, 0)
        audioService.seek(to: 0.5)
        audioService.moveBackword(for: 10)
        XCTAssertEqual(audioService.currentTime, 40)
    }
}
