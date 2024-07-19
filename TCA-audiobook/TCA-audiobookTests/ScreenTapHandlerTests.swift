//
//  ScreenTapHandlerTests.swift
//  TCA-audiobookTests
//
//  Created by Anton Yereshchenko on 19.07.2024.
//

import XCTest

@testable import TCA_audiobook

final class ScreenTapHandlerTests: XCTestCase {

    private var screenBounds: CGRect = .zero

    override func setUp() {
        self.screenBounds = CGRect(
            origin: .zero,
            size: CGSize(width: 100, height: 100)
        )
    }

    func testTopLeftScreenTap() {
        testScreenTap(
            in: CGPoint(x: 25, y: 25),
            with: screenBounds,
            expectationLocation: .topLeft
        )
    }

    func testTopRightScreenTap() {
        testScreenTap(
            in: CGPoint(x: 75, y: 25),
            with: screenBounds,
            expectationLocation: .topRight
        )
    }

    func testBottomRightScreenTap() {
        testScreenTap(
            in: CGPoint(x: 75, y: 75),
            with: screenBounds,
            expectationLocation: .bottomRight
        )
    }

    func testBottomLeftScreenTap() {
        testScreenTap(
            in: CGPoint(x: 25, y: 75),
            with: screenBounds,
            expectationLocation: .bottomLeft
        )
    }
}

private extension ScreenTapHandlerTests {
    func testScreenTap(
        in point: CGPoint,
        with screenBounds: CGRect,
        expectationLocation: ScreenTapHandler.Location
    ) {
        let expectation = XCTestExpectation(description: "Wait for a handler result")

        ScreenTapHandler.handleTap(
            in: point,
            with: screenBounds) { tapLocation in
                expectation.fulfill()
                XCTAssertEqual(tapLocation, expectationLocation)
            }
        
        wait(for: [expectation], timeout: 0.1)
    }
}
