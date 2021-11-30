//
//  FiveHoleTests.swift
//  FiveHoleTests
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import XCTest
@testable import FiveHole

class FiveHoleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShutOut() throws {
        let returnedValue = gameCalculator.calculateSavePercent(savesVar: 50, goalsVar: 0)
        let expectedValue = 100.00
        XCTAssertEqual(returnedValue, expectedValue, accuracy: 0.00000001)
    }
    
    func testNintyPercent() throws {
        let returnedValue = gameCalculator.calculateSavePercent(savesVar: 9, goalsVar: 1)
        let expectedValue = 90.00
        XCTAssertEqual(returnedValue, expectedValue, accuracy: 0.00000001)
    }
    
    func testTotalShots() throws {
        let returnedValue = gameCalculator.calculateTotalShots(savesVar: 35, goalsVar: 3)
        let expectedValue = 38.00
        XCTAssertEqual(returnedValue, expectedValue, accuracy: 0.00000001)
    }
}
