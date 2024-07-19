//
//  TimeComponentsTests.swift
//  TCA-audiobookTests
//
//  Created by Anton Yereshchenko on 19.07.2024.
//

import XCTest

@testable import TCA_audiobook

final class TimeComponentsTests: XCTestCase {
    func testSecondsDescription() {
        let timeComponents = TimeComponents(seconds: 32)
        
        XCTAssertEqual(timeComponents.description, "00:32")
        
        XCTAssertEqual(timeComponents.hours, 0)
        XCTAssertEqual(timeComponents.minutes, 0)
        XCTAssertEqual(timeComponents.seconds, 32)
    }

    func testMinutesDescription() {
        let timeComponents = TimeComponents(seconds: 126)
        
        XCTAssertEqual(timeComponents.description, "02:06")
        
        XCTAssertEqual(timeComponents.hours, 0)
        XCTAssertEqual(timeComponents.minutes, 2)
        XCTAssertEqual(timeComponents.seconds, 6)
    }
    
    func testHoursDescription() {
        let timeComponents = TimeComponents(seconds: 3800)
        
        XCTAssertEqual(timeComponents.description, "01:03:20")
        
        XCTAssertEqual(timeComponents.hours, 1)
        XCTAssertEqual(timeComponents.minutes, 3)
        XCTAssertEqual(timeComponents.seconds, 20)
    }
}
