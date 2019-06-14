//
//  testTests.swift
//  testTests
//
//  Created by  on 2019/5/9.
//  Copyright © 2019年 . All rights reserved.
//


//使用三方测试框架 Quick+Nimble

import Quick
import Nimble

//quick 和 nimble 属于测试驱动开发TDD(Test-driven Development)
/*
 TDD遵循以下循环： 
    先写一个会fail的测试
    补上代码让它通过测试
    Refactor（重构）
    重复以上动作至满意为止
 */

/*
 Quick是基于 XCTest 构建的测试开发框架，支持 Swift 和 Objective-C，并提供了一个DSL来编写测试，非常类似於RSpec。
 Nimble就像是Quick的伙伴，Nimble提供Matcher做为Assertion
 */

//这一行基本上就是标示出我们正在测试的项目目标，然后允许我们从那里 import classes
@testable import test

//必须确保我们的class是QuickSpec的子类，它也是原本XCTestCase的子类
/*
 将使用大量的使用it、describe和context来编写我们的测试。
    其中，每个it代表⼀⼩段测试，
    describe和 context 则是 it 示例的逻辑群集(logical groupings)，用来描述你要测试的是什么。
 */
class testTests:QuickSpec{
    override func spec(){
        //所有测试放在这里

        /*
         当我们测试 TableViewController 的视图层时，需要从 storyboard 中获取一个实例。
         describe闭包(closure)开始我的第一个测试案例，为MoviesTableViewController编写测试。
         beforeEach闭包会在describe闭包中执行，它将在每个范例开始之前运行，所以你可以把它看作为在MoviesTableViewController内的每一个测试被执行前，会先运行这段代码。
         _ = subject.view将视图控制器放入内存中，它就像是调用viewDidLoad。
         最后，我们可以在beforeEach { }之后添加我们的 test assertion，
         */
        var subject : MoviesTableViewController!
        describe("MoviesTableViewControllerSpec") {
            beforeEach {
                subject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesVC") as! MoviesTableViewController
                _ = subject.view
            }
            //Test #1 ----- 预期TableView Rows Count = Movies Data Count
            //添加测试断言
            /*
             我们有一个context，它是一个grouped example closure，被标示为when view is loaded，
             接着是主要示例it should have 8 movies loaded，我们可以预测我们的table view的行数为8，
             现在让我们按下 CMD + U 来运行测试，或者依照 Product -> Test 路径进行测试，在几秒钟后你将在控制台中获得提醒消息:
         
            尚未给MoviesTableViewController添加数据时，执行测试是一个失败的测试： Test Case '-[testTests.testTests MoviesTableViewControllerSpec__when_view_is_loaded__should_have_8_movies_loaded]' failed (0.066 seconds).
             修复：
                回到主要的MoviesTableViewController并加载我们的电影数据！添加这些code之后，再次运行测试，为自己首次通过测试喝彩吧！
                Test Case '-[testTests.testTests MoviesTableViewControllerSpec__when_view_is_loaded__should_have_8_movies_loaded]' passed (0.079 seconds).
             */
            context("when view is loaded", {
                it("should have 8 movies loaded", closure: {
                    expect(subject.tableView.numberOfRows(inSection: 0)).to(equal(8))
                })
            })
            
            //Test #2 ----- 从table view中抓取第一个cell，并测试数据是否匹配
            /*
             尚未给cell赋值时：
                Test Case '-[testTests.testTests MoviesTableViewControllerSpec__Table_View__should_show_movie_title_and_genre]' failed (0.076 seconds).
             修复cell：
                Test Case '-[testTests.testTests MoviesTableViewControllerSpec__Table_View__should_show_movie_title_and_genre]' passed (0.058 seconds).
             */
            context("Table View", {
                var cell : UITableViewCell!
                beforeEach {
                    cell = subject.tableView(subject.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                }
                it("should show movie title and genre", closure: {
                    expect(cell.textLabel?.text).to(equal("The Emoji Movie"))
                    expect(cell.detailTextLabel?.text).to(equal("Animation"))
                })
            })
        }
    }
    
    /*
     总结：
        我们写了第一个测试来检查电影数量，并且让它 fail。
        我们实现逻辑来加载电影，然后让它 pass。
        我们写了第二个测试来检查是否正确显示，并且让它 fail。
        我们实现显示逻辑，然后让测试 pass。
        然后暂停测试工作，接着进行 refactor（重构）。
     */
}



/*import XCTest
@testable import test

class testTests: XCTestCase {
    
    var f1 : Float?
    var f2 : Float?

    //继承于XCTestCase  函数测试文件开始执行的时候运行
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        f1 = 10.0
        f2 = 20.0
    }

    //继承与XCTestCase   测试函数运行完之后执行
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlgorithm(){
        let result = Algorithm.permute([1, 2, 3])
        XCTAssert(result==[[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]],"全排列结果有误")
    }

    //测试的例子函数
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(f1! + f2! == 30.0)
    }
    
    //sipmple test
    func testIsPrimenuber(){
        let oddNumber = 5
        XCTAssert(isPrimenumber(Double(oddNumber)))
    }
    func isPrimenumber(_ number : Double)->Bool{
        for no in 1...Int(sqrt(number)) {
            if Int(number)/no != 0{
                return true
            }
        }
        return false
    }

    //性能测试
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
 */
