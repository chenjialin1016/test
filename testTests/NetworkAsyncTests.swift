//
//  NetworkAsyncTests.swift
//  testTests
//
//  Created by Jialin Chen on 2019/6/14.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//


//测试异步网络Alamofire

import XCTest
import Alamofire

@testable import test

class NetworkAsyncTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAsynNetworkTest() {
        let networkExpection = expectation(description: "networkDownSuccess")
        Alamofire.request("http://www.httpbin.org/get?key=Xctest", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (respons) in
            XCTAssertNotNil(respons)
            networkExpection.fulfill()
            }
        
        //设置XCWaiter等待期望时间，只是细节不同。
//        waitForExpectations(timeout: 0.00000001)
//        wait(for: [networkExpection], timeout: 0.00000001)

            
        //XCTWaiter.Result  枚举类型如下
        /*
        public enum Result : Int {
            
            
            case completed
            
            case timedOut
            
            case incorrectOrder
            
            case invertedFulfillment
            
            case interrupted
        }
        */
        let result = XCTWaiter(delegate: self).wait(for: [networkExpection], timeout:  1)
        if result == .timedOut {
            print("超时")
        }
        
    }

    func testPerformanceExample() {
        
        self.measure {
           
        }
    }

}
