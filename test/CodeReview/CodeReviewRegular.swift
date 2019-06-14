//
//  CodeReviewRegular.swift
//  test
//
//  Created by  on 2019/6/3.
//  Copyright © 2019年 . All rights reserved.
//

import Foundation

/*
 为什么要重构代码？什情况下需要重构？
 答：代码重构可以改善既有的代码设计，增强既有过程的可扩充性、可维护性。随着需求的不断迭代/更新，所写的代码也在时刻变化，新增的功能模块，可能在下次就不用了，或者需求更新/变更，使原有的方法变得臃肿，以及各个模块的耦合度增加，这些都需要代码重构
 
 什么是重构？
 答：在不改变代码对外的表现的情况下，修改代码的内部特征，即对既有代码的结构进行修改
 */

//代码重构规则

//MARK:-----------1、函数重构规则-----------
/*
 Extract Method, Inline Method, Inline Temp, Replace Temp with Query, Introduce Explaining Variable, Split Temporary Variable, Remove Assignments to Parameters, Replace Method with Method Object
 */
func methodReviewTest(){
    print("函数重构----Extract Method 提取函数")
    let myCustome : MyCustomer = MyCustomer("zeluli", [10, 20, 30, 40, 50])
    myCustome.printOwing()
    print("\n")
    
    print("函数重构----Replace Temp with Query 以查询取代临时变量")
    let product : Product = Product(1, itemPrice: 1000)
    let price = product.getPrice()
    print(price)
    print("\n")
    
    print("函数重构----Introduce Explaining Variable(引入解释性变量)")
    let product1: Product1 = Product1(1, itemPrice: 1000)
    let price1 = product1.getPrice()
    print(price)
    print("\n")
    
    print("函数重构----Split Temporary Variable 分解临时变量")
    splitTemp()
    print("\n")
    
    print("函数重构----Remove Assignments to Parameters(移除对参数的赋值)")
    var inputval = 50
    let count = discount(inputVal: &inputval, quantity: 200, yearToDate: 5500)
    print(count)
    print("\n")
    
    print("函数重构----Replace Method with Method Object(以函数对象取代函数)")
    let count2 = Account().discount(inputVal: &inputval, quantity: 200, yearToDate: 5500)
    print(count2)
    print("\n")
}


//MARK:-----------2、类重构规则-----------

func classReviewTest(){
    print("类重构----Move Method 方法迁移")
    let bookCustomer = BookCustomer("cjl", true)
    bookCustomer.books.append(Book(0, "book name 1"))
    bookCustomer.books.append(Book(1, "book name 2"))
    bookCustomer.books.append(Book(2, "book name 3"))
    print(bookCustomer.charge())
    print("\n")
    
    print("类重构----Move Class 提炼类")
    let employee : Employee = Employee("cjl", TelPhoneNumber("010", "0123456789"))
    print(employee.getOfficeAreaCode())
    print(employee.getOfficeNumber())
    print("\n")
    
    print("类重构----Inline Class 内联类")
    print("无示例\n")
    
    print("类重构----Hide Delegate 隐藏“委托关系”")
    let scotterManager = People("scott", Department("creditease", nil))
     let cjl = People("cjl", Department("creditease", scotterManager))
//    print("重构前：", cjl.department.manager.name)
    print("重构后：", cjl.getManager().name)
    print("\n")
    
    print("类重构----Introduce Foreign Method 引入外加函数")
    MyTest.method1()
    MyTest.method2()
    print("\n")
}


//MARK:-----------3、数据重构规则-----------
func dataReviewTest(){
    print("数据重构----Self Encapsulate Field 自封装字段")
    var capRange : CappedRange = CappedRange.init(10, 100, 50)
    print(capRange.getHigh())
    print(capRange.include(51))
    print(capRange.include(50))
    print("\n")
}


//MARK:-----------4、条件表达式重构规则-----------
func conditionalExpressionReviewTest(){
    
}

//MARK:-----------5、继承关系重构规则-----------
func extendsReviewTest(){
    
}


//MARK:-----------6、代码冲能够完整案例-----------
