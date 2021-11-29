//
//  FiveHoleUITests.swift
//  FiveHoleUITests
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import XCTest

class FiveHoleUITests: XCTestCase {

    /// Measure warm launch over 5 iterations (after one throw-away launch)
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric(waitUntilResponsive: true)]) {
            XCUIApplication().launch()
        }
    }
}
