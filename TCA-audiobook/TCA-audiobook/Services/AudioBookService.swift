//
//  AudioBookService.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 26.12.2023.
//

import Foundation

class AudioBookService {
    typealias BookItem = EnglishFairyTales
    
    private let audioService: AudioService
    
    private var audioBooks: [BookItem] = []
    private(set) var currentAudioBook: (BookItem)?
    
    var currentTime: TimeInterval {
        get { audioService.currentTime }
        set { audioService.currentTime = newValue}
    }
    
    var duration: TimeInterval {
        return audioService.duration
    }
    
    var speed: AudioSpeed {
        return audioService.speed
    }
    
    init() {
        self.audioService = AudioService()
    }
    
    func configurate(with audioBooks: [BookItem]) throws {
        if self.audioBooks.isEmpty {
            self.audioBooks = audioBooks
            currentAudioBook = audioBooks.first
            
            try audioService.configurate()
        }
        
        audioService.onDidFinishPlaying = { [weak self] state in
            if state {
                let _ = try? self?.nextItem()
            }
        }
    }
    
    func play() throws -> Bool {
        return try audioService.play(
            audiobook: currentAudioBook
        )
    }
    
    func pause() {
        audioService.pause()
    }
    
    func moveBackword() {
        audioService.moveBackword(
            for: Constants.backwordSeekingPortion
        )
    }
    
    func moveForward() {
        audioService.moveForward(
            for: Constants.forwardSeekingPortion
        )
    }
    
    func previousItem() throws -> BookItem? {
        guard let book = currentAudioBook?.previous else { return nil }
        
        currentAudioBook = book
        audioService.stop()
        if try audioService.play(audiobook: book) {
            return book
        }
        return nil
    }
    
    func nextItem() throws -> BookItem? {
        guard let book = currentAudioBook?.next else { return nil }
        
        currentAudioBook = book
        audioService.stop()
        if try audioService.play(audiobook: book) {
            return book
        }
        return nil
    }
    
    func changeSpeed(_ speed: AudioSpeed) {
        audioService.changeSpeed(speed)
    }
    
    func seek(to value: Double) {
        audioService.seek(to: value)
    }
}

private extension AudioBookService {
    enum Constants {
        static let backwordSeekingPortion = 5.0
        static let forwardSeekingPortion = 10.0
    }
}
