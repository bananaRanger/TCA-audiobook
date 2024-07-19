//
//  CaseIterableNearestTest.swift
//  TCA-audiobookTests
//
//  Created by Anton Yereshchenko on 19.07.2024.
//

import XCTest

@testable import TCA_audiobook

final class CaseIterableNearestTest: XCTestCase {
    func testPreviousAction() {
        XCTAssertEqual(MockCaseIterable.one.previous, .three)
        XCTAssertEqual(MockCaseIterable.two.previous, .one)
        XCTAssertEqual(MockCaseIterable.three.previous, .two)
    }
    
    func testNextAction() {
        XCTAssertEqual(MockCaseIterable.one.next, .two)
        XCTAssertEqual(MockCaseIterable.two.next, .three)
        XCTAssertEqual(MockCaseIterable.three.next, .one)
    }
}

fileprivate enum MockCaseIterable: CaseIterable {
    case one
    case two
    case three
}
