//
//  test1UITests.swift
//  test1UITests
//
//  Created by Jialin Chen on 2019/6/17.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit
import XCTest
import KIF


extension XCTestCase {
    func tester(file : String = #file,_ line : Int = #line)->KIFUITestActor{
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    func system(file : String = #file,_ line : Int = #line)->KIFSystemTestActor{
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

class test1UITests: KIFTestCase {

    //所有测试进行前调用，可以做一些必要或者共有的初始化操作
    override func beforeAll() {
        
    }
    
    //测试点击登录后进入其他view
    func test00Login(){
        //点击kif按钮，跳转至登录界面
        tester().tapView(withAccessibilityLabel: "KIF")
        tester().waitForView(withAccessibilityLabel: "login")
        
        let nameTextField = tester().waitForView(withAccessibilityLabel: "UserName") as! UITextField
        let pwdTextField = tester().waitForView(withAccessibilityLabel: "Password") as! UITextField
        tester().enterText("User", intoViewWithAccessibilityLabel: "UserName")
        tester().enterText("123456", intoViewWithAccessibilityLabel: "Password")
        //点击登录按钮
        tester().tapView(withAccessibilityLabel: "login")
        //断言
        XCTAssertTrue((nameTextField.text?.isEmpty)!, "User name can't be nil")
        XCTAssertTrue((pwdTextField.text?.isEmpty)!, "Password can't be nil")
        
        //等待某个viiew出现，也可以通过该函数得到该view的实例
        tester().waitForView(withAccessibilityLabel: "Scene1")
    }
    
    //测试切换不同的view
    func test01TabButtons(){
        tester().tapView(withAccessibilityLabel: "Tab2")
        tester().waitForView(withAccessibilityLabel: "Scene2")
        
        tester().tapView(withAccessibilityLabel: "Tab3")
        tester().waitForView(withAccessibilityLabel: "Scene3")
    }
    
    //测试输入
    func test02Input(){
        tester().tapView(withAccessibilityLabel: "Tab1")
        tester().waitForView(withAccessibilityLabel: "InputTextField")
        
        //输入文字
        tester().enterText("Hello KIF", intoViewWithAccessibilityLabel: "InputTextField")
        
        //todo:如何确定键盘弹出来的done按钮的accessibilityLabel？
        tester().tapView(withAccessibilityLabel: "Scene1View")
        
        //得到view实例
        let textField = tester().waitForView(withAccessibilityLabel: "InputTextField") as! UITextField
        //判断是否相等
        XCTAssertEqual(textField.text, "Hello KIF")
        
        //清除当前文字，重新输入新的
        tester().clearText(fromAndThenEnterText: "Test Geometry", intoViewWithAccessibilityLabel: "InputTextField")
        tester().tapView(withAccessibilityLabel: "Scene1View")
    }
    
    //有时候无法确定accessibilityLabel或者自定义的空间没有accessibilityLabel，可以使用Geometry计算位置进行
    func test03Geometry(){
        tester().wait(forTimeInterval: 2)
        
        let stepper = tester().waitForView(withAccessibilityLabel: "stepper") as! UIStepper
        let stepCenter = stepper.window?.convert(stepper.center, to: stepper.superview)
        //算出-和+的位置
        var minusButton = stepCenter
        minusButton!.x -= stepper.frame.width/4
        var plusButton = stepCenter
        plusButton!.x += stepper.frame.width/4
        
        for _ in 0..<10 {
            tester().wait(forTimeInterval: 1)
            tester().tapScreen(at: minusButton!)
        }
        
        //延时1s
        tester().wait(forTimeInterval: 1)
        tester().tapScreen(at: plusButton!)
        tester().wait(forTimeInterval: 1)
        tester().tapScreen(at: plusButton!)
        tester().wait(forTimeInterval: 1)
        
        //设置超时时间
        KIFTestActor.setDefaultTimeout(60)
        
        tester().tapView(withAccessibilityLabel: "Tab2")

        KIFTestActor.setDefaultTimeout(10)
    }

}
