//
//  SampleTests.swift
//  testTests
//
//  Created by Jialin Chen on 2019/6/14.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

//简单的应用例子

import XCTest
@testable import test

class SampleTests: XCTestCase {
    
    var f1 : Float?
    var f2 : Float?

    override func setUp() {
        super.setUp()
        
        //在测试方法执行前设置变量
        f1 = 10.0
        f2 = 20.0
    }

    override func tearDown() {
        //在测试方法执行完成后，清除变量
       super.tearDown()
    }

    func testExample() {
        XCTAssertTrue(f1! + f2! == 30.0)
    }
    
    //simpleTest
    func testIsPrimenumber(){
        let oddNumber = 5
        XCTAssertTrue(isPrimenumber(Double(oddNumber)))
    }
    func isPrimenumber(_ number : Double)->Bool{
        for no in 1...Int(sqrt(number)) {
            if Int(number)/no != 0{
                return true
            }
        }
        return false
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
