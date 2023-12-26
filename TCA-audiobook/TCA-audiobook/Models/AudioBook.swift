//
//  AudioBook.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 24.12.2023.
//

import Foundation

protocol AudioBook: CaseIterable, Equatable {
    var fileName: String { get }
    var fileExtension: String { get }
}

/**
 Joseph Jacobs (1854-1916)
 English Fairy Tales
 */
enum EnglishFairyTales: String, AudioBook {
    case preface = "Preface"
    case tomTitTot = "Tom Tit Tot"
    case theThreeSillies = "The Three Sillies"
    case theRoseTree = "The Rose Tree"
    case theOldWomanAndHerPig = "The Old Woman and Her Pig"
    case howJackWentToSeekHisFortune = "How Jack Went to Seek His Fortune"
}

extension EnglishFairyTales {
    var fileName: String {
        let index = EnglishFairyTales.allCases.firstIndex(of: self)
        let string = String(
            format: "english_fairy_tales_%.2d_64kb",
            index ?? .zero
        )
        return string
    }
    
    var fileExtension: String {
        return "mp3"
    }
}
