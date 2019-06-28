//
//  BananaQuickTests.swift
//  testTests
//
//  Created by Jialin Chen on 2019/6/20.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//


import Quick
import Nimble
@testable import test

class DolphinQuickTests: QuickSpec {
    
    override func spec(){
        //所有测试放在这里
       
        // describe用于描述类和方法
        describe("a dolphin", closure: {
            var dolphin : Dolphin!
            
             // beforeEach/afterEach相当于setUp/tearDown,beforeSuite/afterSuite相当于全局setUp/tearDown
            beforeEach {
                dolphin = Dolphin()
            }
            
            describe("its click", closure: {
                var click : Click!
                beforeEach {
                    click = dolphin.click()
                }
                
                // context用于指定条件或状态
                context("when the dolphin is not near anything interesting", closure: {
                    
                    // it用于描述测试的方法名
                    it("it only emited once", closure: {
                        expect(click.count()).to(equal(1))
                    })
                })
                
                context("when the dolphin is near something interesting", closure: {
                    it("it emited three times", closure: {
                        expect(click.count()).to(equal(3))
                    })
                })
            })
        })
    }
    
}
