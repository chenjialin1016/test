//
//  ProjectTests.swift
//  testTests
//
//  Created by Jialin Chen on 2019/6/13.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

//使用苹果官方测试框架 XCTest

import XCTest
@testable import test

class ProjectTests: XCTestCase {
    

    // 方法在XCTestCase的测试方法调用之前调用，可以在测试之前创建在test case方法中需要用到的一些对象等
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    // 当测试全部结束之后调用tearDown方法，目的是全部的test case执行结束以后清理测试现场，释放资源删除不用的对象等
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_asDictionary(){
        //1、创建一个测试和你想要存在的实例,编译失败，其余步骤在projectclass 类中
        let project = Project(5)
        //3、在测试中，调用你想要存在的方法
        let dict = project.asDictionary()

        //5、编写一个断言
        XCTAssertEqual(dict["id"] as? Int, 5)
    }

    // 测试代码执行性能
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}

