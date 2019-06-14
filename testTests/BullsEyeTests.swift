//
//  BullsEyeTests.swift
//  testTests
//
//  Created by Jialin Chen on 2019/6/14.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

//测试模型类

import XCTest
@testable import test

class BullsEyeTests: XCTestCase {

    var gameUnderTest : BullsEyeGame!
    
    override func setUp() {
        super.setUp()
        
        gameUnderTest = BullsEyeGame()
        gameUnderTest.startNewGame()
    }

    override func tearDown() {
        gameUnderTest = nil
        
        super.tearDown()
    }

    // XCTAssert to test model
    func testScoreIsComputedWhenGuessGTTarget() {
        // 1. given
        let guess = gameUnderTest.targetValue + 5
        
        // 2. when
        _ = gameUnderTest.check(guess: guess)
        
        // 3. then
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "Score computed from guess is wrong")
    }
    //测试人为debug，在断点导航器中，添加一个 Test Failure 断点，这样，当测试方法断言失败时，测试会停止。
    func testScoreIsComputedWhenGuessLTTarget() {
        // 1. given
        let guess = gameUnderTest.targetValue - 5
        
        // 2. when
        _ = gameUnderTest.check(guess: guess)
        
        // 3. then
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "Score computed from guess is wrong")
    }

    func testPerformanceExample() {
        
        self.measure {
            
        }
    }

}
