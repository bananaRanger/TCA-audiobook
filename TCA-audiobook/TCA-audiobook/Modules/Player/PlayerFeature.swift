//
//  PlayerFeature.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 26.12.2023.
//

import ComposableArchitecture

struct Player: Reducer {
    struct State: Equatable {
        var audioBookItems: [EnglishFairyTales] = EnglishFairyTales.allCases
        var currentBookItem: EnglishFairyTales? = EnglishFairyTales.allCases.first

        var speed: AudioSpeed = ._1_0

        var isPlaying: Bool = false

        var progress: Double = .zero
        
        var currentTime: TimeComponents = .init(seconds: .zero)
        var duration: TimeComponents = .init(seconds: .zero)
    }
    
    enum Action: Sendable {
        case onAppear
        case onTimerUpdate
        case play
        case pause
        
        case perevious
        case next
        
        case moveBackword
        case moveForward
        
        case changeSpeed
        
        case onSliderValueChange(Double)
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.audioBookService) var audioBookService
    
    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .onAppear:
            do {
                try audioBookService.configurate(
                    with: state.audioBookItems
                )
            } catch {
                print(" \(error) ")
            }
            
            return .run { send in
                for await _ in self.clock.timer(interval: .milliseconds(500)) {
                  await send(.onTimerUpdate)
                }
            }
        case .onTimerUpdate:
            state.currentTime = .init(seconds: audioBookService.currentTime)
            state.duration = .init(seconds: audioBookService.duration)
            state.progress = audioBookService.currentTime / audioBookService.duration
            state.currentBookItem = audioBookService.currentAudioBook
            state.speed = audioBookService.speed
            return .none
        case .play:
            do {
                state.isPlaying = try audioBookService.play()
            } catch {
                print(" \(error) ")
            }
            return .none
        case .pause:
            state.isPlaying = false
            audioBookService.pause()
            return .none
        case .perevious:
            do {
                state.currentBookItem = try audioBookService.previousItem()
                if !state.isPlaying { audioBookService.pause() }
            } catch {
                print(" \(error) ")
            }
            return .none
        case .next:
            do {
                state.currentBookItem = try audioBookService.nextItem()
                if !state.isPlaying { audioBookService.pause() }
            } catch {
                print(" \(error) ")
            }
            return .none
        case .moveBackword:
            audioBookService.moveBackword()
            return .none
        case .moveForward:
            audioBookService.moveForward()
            return .none
        case .changeSpeed:
            if let speed = state.speed.next {
                state.speed = speed
                audioBookService.changeSpeed(speed)
            }
            return .none
        case .onSliderValueChange(let value):
            state.progress = value
            audioBookService.seek(to: value)
            return .none
        }
    }
}

extension Player.State {
    var currentIndex: Int {
        var index = 1
        if let book = currentBookItem,
            let newIndex = audioBookItems.firstIndex(of: book) {
            index = newIndex + 1
        }
        return index
    }
}

private enum AudioBookServiceWrapper: DependencyKey {
    static let liveValue = AudioBookService()
}

extension DependencyValues {
    var audioBookService: AudioBookService {
        get { self[AudioBookServiceWrapper.self] }
        set { self[AudioBookServiceWrapper.self] = newValue }
    }
}
