//
//  BullsEyeMockTests.swift
//  BullsEyeMockTests
//
//  Created by Jialin Chen on 2019/6/14.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

//模拟写入 mock 对象

import XCTest
@testable import test

//MockUserDefaults 重写了 set(_:forKey:) 方法，用于增加 gameStyleChanged 的值。通常你可能认为应当使用 Bool 变量，但使用 Int 能带来更多的好处——例如，在你的测试中你可以检查这个方法是否真的被调用过一次。
class MockUserDefaults: UserDefaults {
    var gameStyleChanged = 0
    override func set(_ value: Int, forKey defaultName: String) {
        if defaultName == "gameStyle" {
            gameStyleChanged += 1
        }
    }
}

class BullsEyeMockTests: XCTestCase {

    //声明 SULT 和 MockUserDefaults 对象：
    var BullsEyeUnderTest: BullsEyeGameViewController!
    var mockUserDefaults: MockUserDefaults!
    
    override func setUp() {
        super.setUp()
        //创建 SUT 和伪造对象，然后将伪造对象注入到 SUT 的属性中
        BullsEyeUnderTest = UIStoryboard(name: "Main",
                                         bundle: nil).instantiateViewController(withIdentifier: "BullsEyeGameVC") as! BullsEyeGameViewController
        mockUserDefaults = MockUserDefaults(suiteName: "testing")!
        BullsEyeUnderTest.defaults = mockUserDefaults
    }
    
    override func tearDown() {
        //释放 SUT 和伪造对象：
        BullsEyeUnderTest = nil
        mockUserDefaults = nil
        super.tearDown()
    }
    
    // 模拟和 UserDefaults 的交互
    func testGameStyleCanBeChanged() {
        // given
        let segmentedControl = UISegmentedControl()
        
        // when
        XCTAssertEqual(mockUserDefaults.gameStyleChanged, 0, "gameStyleChanged should be 0 before sendActions")
        segmentedControl.addTarget(BullsEyeUnderTest,
                                   action: #selector(BullsEyeGameViewController.chooseGameStyle(_:)), for: .valueChanged)
        segmentedControl.sendActions(for: .valueChanged)
        
        // then
        XCTAssertEqual(mockUserDefaults.gameStyleChanged, 1, "gameStyle user default wasn't changed")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
