//
//  AddViewController.swift
//  test
//
//  Created by Jialin Chen on 2019/6/24.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

class AddViewController: UIViewController{

    @IBOutlet weak var firstNumTextField: UITextField!
    @IBOutlet weak var secondNumTextField: UITextField!
    @IBOutlet weak var resultTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //获取第一个输入框的值
    func getFirstNumber()->String{
        return firstNumTextField!.text!
    }
    
    //获取第二个输入框的值
    func getSecondNumber()->String{
        return secondNumTextField.text!
    }
    
    @IBAction func textFieldChange(_ sender: Any) {
        self.resultTextField.text = calculate(getFirstNumber(), second: getSecondNumber())
    }
    
    //计算两个数的值
    func calculate(_ first : String, second : String)->String{
        return String(stringToInt(first)+stringToInt(second))
    }
    
    //将字符串安全的转换成整数的函数
    func stringToInt(_ str : String)->Int{
        guard let result = Int(str) else {
            return 0
        }
        return result
    }
    
    
}

