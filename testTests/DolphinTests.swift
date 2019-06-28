//
//  BananaTests.swift
//  testTests
//
//  Created by Jialin Chen on 2019/6/20.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import XCTest
import Nimble

class DolphinTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testA_Dolphin_its_click_whenTheDolphinIsNearSomethingInteresting(){
        //given / arrange
        let dolphin : Dolphin = Dolphin()
        
        
        //when / act
        let click = dolphin.click()
        
        //then / assert
        XCTAssertEqual(click.count(), 3)
    }
    
    func testA_Dolphin_its_click_whenTheDolphinIsNotNearAnythingInteresting(){
        //given / arrange
        let dolphin : Dolphin = Dolphin()
        
        
        //when / act
        let click = dolphin.click()
        
        //then / assert
        XCTAssertEqual(click.count(), 1)
        
    }
    
    func testA_Dolphin_its_click_whenTheDolphinIsNearSomethingInteresting2(){
        //given / arrange
        let dolphin : Dolphin = Dolphin()
        
        
        //when / act
        let click = dolphin.click()
        
        //then / assert
//        XCTAssertEqual(click.count(), 3)
        expect(click.count()).to(equal(3))
    }
    
    func testA_Dolphin_its_click_whenTheDolphinIsNotNearAnythingInteresting2(){
        //given / arrange
        let dolphin : Dolphin = Dolphin()
        
        
        //when / act
        let click = dolphin.click()
        
        //then / assert
//        XCTAssertEqual(click.count(), 1)
        expect(click.count()).to(equal(1))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
