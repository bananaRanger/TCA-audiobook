//
//  EnglishFairyTalesTests.swift
//  TCA-audiobookTests
//
//  Created by Anton Yereshchenko on 19.07.2024.
//

import XCTest

@testable import TCA_audiobook

final class EnglishFairyTalesTests: XCTestCase {
    func testFileNames() {
        XCTAssertEqual(EnglishFairyTales.preface.fileName, "english_fairy_tales_00_64kb")
        XCTAssertEqual(EnglishFairyTales.tomTitTot.fileName, "english_fairy_tales_01_64kb")
        XCTAssertEqual(EnglishFairyTales.theThreeSillies.fileName, "english_fairy_tales_02_64kb")
        XCTAssertEqual(EnglishFairyTales.theRoseTree.fileName, "english_fairy_tales_03_64kb")
        XCTAssertEqual(EnglishFairyTales.theOldWomanAndHerPig.fileName, "english_fairy_tales_04_64kb")
        XCTAssertEqual(EnglishFairyTales.howJackWentToSeekHisFortune.fileName, "english_fairy_tales_05_64kb")
    }
}
