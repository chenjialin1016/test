//
//  testUITests.swift
//  testUITests
//
//  Created by  on 2019/5/9.
//  Copyright © 2019年 . All rights reserved.
//

import XCTest

class testUITests: XCTestCase {

    var app : XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUI(){
        
//        let app = XCUIApplication()
        let tddButton = app.buttons["TDD驱动测试界面"]
        tddButton.tap()
        
        let backButton = app.navigationBars["test.MoviesTableView"].buttons["Back"]
        backButton.tap()
        tddButton.tap()
        backButton.tap()
        
        
    }
    
    /*
     报错：The bundle “testUITests” couldn’t be loaded because it is damaged or missing necessary resources. Try reinstalling the bundle.
     原因：由于在podfile中导入了三方框架，注释掉就可以了
     https://stackoverflow.com/questions/40480503/the-bundle-uitests-couldn-t-be-loaded-because-it-is-damaged-or-missing-necessary
     */

}
