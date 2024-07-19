//
//  MockAudioBook.swift
//  TCA-audiobookTests
//
//  Created by Anton Yereshchenko on 19.07.2024.
//

import Foundation

@testable import TCA_audiobook

enum MockAudioBook: String, AudioBook {
    case vanityFair
    case braveNewWorld
    
    var fileName: String {
        return rawValue
    }
    
    var fileExtension: String {
        return "mp3"
    }
}
