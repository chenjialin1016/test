//
//  AddReviewViewController.swift
//  test
//
//  Created by Jialin Chen on 2019/6/24.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

class AddReviewViewController: UIViewController {
    
    @IBOutlet weak var firstNumTextField: UITextField!
    @IBOutlet weak var secondNumTextField: UITextField!
    @IBOutlet weak var resultTextField: UITextField!
    
    lazy var calculate : Calculate = Calculate()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        calculate.setFirstNumber(firstNumTextField.text!)
        calculate.setSecondNumber(secondNumTextField.text!)
        self.resultTextField.text = calculate.resultNumber
    }

}

//提取的业务数据类
class Calculate{
    //存储属性
    private var firstNumber : String
    private var secondNumber : String
    
    //计算属性
    var resultNumber : String{
        get{
            return calculate(firstNumber, second: secondNumber)
        }
    }
    
    //构造函数
    init() {
        self.firstNumber = "0"
        self.secondNumber = "0"
    }
    
    //设置方法
    func setFirstNumber(_ firstNumber : String){
        self.firstNumber = firstNumber
    }
    func setSecondNumber(_ secondNumber : String){
        self.secondNumber = secondNumber
    }
    
    
    //业务逻辑代码。与UI无关的东西，可以进行提取
    //计算两个数的值
    private func calculate(_ first : String, second : String)->String{
        return String(stringToInt(first)+stringToInt(second))
    }
    
    //将字符串安全的转换成整数的函数
    private func stringToInt(_ str : String)->Int{
        guard let result = Int(str) else {
            return 0
        }
        return result
    }
}
