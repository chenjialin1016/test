//
//  testSimulationObjectsTests.swift
//  testSimulationObjectsTests
//
//  Created by Jialin Chen on 2019/6/14.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

//模拟对象和交互
//使用了 stub (存根)来从伪造对象中获取数据

import XCTest
@testable import test

class testSimulationObjectsTests: XCTestCase {
    //声明SUT被测对象
    var controllerUnderTest: SearchViewController!
    
    override func setUp() {
        super.setUp()
        //构建SUT对象
        controllerUnderTest = UIStoryboard(name: "Main",
                                           bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchViewController
        
        //获取下载好并拖入项目的json文件
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "abbaData", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        //项目中有一个 DHURLSessionMock.swift 文件。它定义了一个简单的协议 DHURLSession，包含了用 URL 或者 URLRequest 来创建 data taks 的方法。还有实现了这个协议的 URLSessionMock 类，它的初始化方法允许你用指定的数据、response 和 error 来创建一个伪造的 URLSession
        //构造模拟数据和response
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        //创建一个伪造的session对象
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        //将伪造的对象注入app的属性中
        controllerUnderTest.defaultSession = sessionMock
    }
    
    override func tearDown() {
        //释放SUT对象
        controllerUnderTest = nil
        super.tearDown()
    }
    
    // 用 DHURLSession 协议和模拟数据伪造 URLSession
    func test_UpdateSearchResults_ParsesData() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        XCTAssertEqual(controllerUnderTest?.searchResults.count, 0, "searchResults should be empty before the data task runs")
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        let dataTask = controllerUnderTest?.defaultSession.dataTask(with: url!) {
            data, response, error in
            // 如果 HTTP 请求成功，调用 updateSearchResults(_:) 方法，它会将数据解析成 Tracks 对象
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    promise.fulfill()
                    self.controllerUnderTest?.updateSearchResults(data)
                }
            }
        }
        dataTask?.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertEqual(controllerUnderTest?.searchResults.count, 3, "Didn't parse 3 items from fake response")
    }
    
    // Performance
    func test_StartDownload_Performance() {
        let track = Track(name: "Waterloo", artist: "ABBA", previewUrl: "http://a821.phobos.apple.com/us/r30/Music/d7/ba/ce/mzm.vsyjlsff.aac.p.m4a")
        measure {
            self.controllerUnderTest?.startDownload(track)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
        
}
