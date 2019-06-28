//
//  ConditionReview.swift
//  test
//
//  Created by Jialin Chen on 2019/6/27.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//
//https://www.cnblogs.com/ludashi/p/5257273.html
import UIKit

//MARK:===========1、Decompose Conditional(分解条件表达式)
/*1、Decompose Conditional(分解条件表达式)
 
 现象：某个条件语句非常的复杂
 解决方案：从if、else等条件自己提取独立函数
 */
//--------------------------重构前--------------------------
/*
class Commission{
    func fetchCommission(_ money : Double, day : Int)->Double{
        if money > 10_000 && day > 30 {
            //假设为一些复杂的处理
            return money * Double(day) / 365 * 0.2
        }else{
            //假设为一些复杂的处理
            return money * 30.0 / 365 * 0.1
        }
    }
}
*/
//--------------------------重构后--------------------------
class Commission{
    func fetchCommission(_ money : Double, day : Int)->Double{
        if isALotOfMoney(money, day) {
            return aLotOfMoney(money, day)
        }else{
            return littleMoney(money)
        }
    }
    
    private func isALotOfMoney(_ money : Double, _ day : Int)->Bool{
        return money > 10_000 && day > 30
    }
    private func aLotOfMoney(_ money : Double, _ day : Int)->Double{
        return money * Double(day) / 365 * 0.2
    }
    private func littleMoney(_ money : Double)->Double{
        return money * 30.0 / 365 * 0.1
    }
}

//MARK:===========2、Consolidate Conditional Expression(合并条件表达式)
/*2、Consolidate Conditional Expression(合并条件表达式)
 
 现象：一些列的条件都会得到同样的结果
 解决方案：将这些条件进行合并
 */
//--------------------------重构前--------------------------
/*
class testDemo{
    var number1 : Int
    var number2 : Int
    var number3 : Int
    
    init(_ number1 : Int, _ number2 : Int, _ number3 : Int) {
        self.number1 = number1
        self.number2 = number2
        self.number3 = number3
    }
    func fetchResult()->Int{
        //第一次需求迭代
        if number1 > 10 {
            return 30
        }
        //第二次需求迭代
        if number2 > 50 {
            return 30
        }
        //第三次需求迭代
        if number3 > 60 {
            return 30
        }
       return 0
    }
}
*/
//--------------------------重构后--------------------------
class testDemo{
    var number1 : Int
    var number2 : Int
    var number3 : Int
    
    init(_ number1 : Int, _ number2 : Int, _ number3 : Int) {
        self.number1 = number1
        self.number2 = number2
        self.number3 = number3
    }
    //重构1
    func fetchResult1()->Int{
        if number1 > 10 || number2 > 50 || number3 > 60{
            return 30
        }
        return 0
    }
        
    //重构2
    func fetchResult2()->Int{
        if isTrue() {
            return 30
        }
        return 0
    }
    func isTrue()->Bool{
        return number1 > 10 || number2 > 50 || number3 > 60
    }
}

//MARK:===========3、Consolidate Duplicate Conditional Fragments(合并重复的条件片段)
/*3、Consolidate Duplicate Conditional Fragments(合并重复的条件片段)
 
 现象：在条件表达式的每个分支上有着相同的片段
 解决方案：这段重复的代码移动到表达式之外
 */
//--------------------------重构前--------------------------
/*
func totalMoney(_ price : Double){
    var total : Double
    if price > 1000 {
        total = price*0.8
        print(total)
    }else{
        total = price * 0.7
        print(total)
    }
}
*/
//--------------------------重构后--------------------------
func totalMoney(_ price : Double){
    var total : Double
    if price > 1000 {
        total = price*0.8
    }else{
        total = price * 0.7
    }
    print(total)
}

//MARK:===========4、Remove Control Flag(移除控制标记)
/*4、Remove Control Flag(移除控制标记)
 
 现象：开发中会使用一些标记变量来标记一些食物的状态，但是标记变量不易维护、不易理解
 解决方案：移除标记变量，可以使用break、return、continue等等代替
 */
//--------------------------重构前--------------------------
/*
func testRemoveControlFlag(){
    var flag : Bool = true
    for i in 0..<100 {
        if flag {
            if i == 20{
                flag = false
            }else{
                print("*")
            }
        }
    }
}
*/
//--------------------------重构后--------------------------
func testRemoveControlFlag(){
    for i in 0..<100 {
        if i == 20 {
            break
        }
        print("*")
    }
}

//MARK:===========5、Replace Nested Condition with Guard Clauses(以卫语句取代嵌套的条件)
/*5、Replace Nested Condition with Guard Clauses(以卫语句取代嵌套的条件)
 
 现象：多个条件进行嵌套，难于理解
 解决方案：使用卫语句表现所有特殊情况
 */
//--------------------------重构前--------------------------
/*
func conditionNest(){
    let keys = [1, 2, 3, 4]
    let numberDictionary = [1:"number1", 2:"number2"]
    let nameDictionary = ["number1":"cjl"]
    let ageDictionary = ["cjl":18]
    
    for key in keys {
        if let number = numberDictionary[key] {
            if let name = nameDictionary[number]{
                if let age = ageDictionary[name]{
                    print(age)
                }
            }
        }
    }
}
*/
//--------------------------重构后--------------------------
//使用将条件翻转
func conditionNest(){
    let keys = [1, 2, 3, 4]
    let numberDictionary = [1:"number1", 2:"number2"]
    let nameDictionary = ["number1":"cjl"]
    let ageDictionary = ["cjl":18]
    
    for key in keys {
        let number = numberDictionary[key]
        if number == nil {
            continue
        }
        let name = nameDictionary[number!]
        if name == nil {
            continue
        }
        let age = ageDictionary[name!]
        if age == nil {
            continue
        }
        print(age)
    }
}
//使用guard语句
func conditionNest2(){
    let keys = [1, 2, 3, 4]
    let numberDictionary = [1:"number1", 2:"number2"]
    let nameDictionary = ["number1":"cjl"]
    let ageDictionary = ["cjl":18]
    
    for key in keys {
        
        guard let number = numberDictionary[key] else {
            continue
        }
        guard let name = nameDictionary[number] else{
            continue
        }
         guard let age = ageDictionary[name] else{
            continue
        }
        print(age)
    }
}

//MARK:===========6、Replace Condition with Polymorphism(以多态取代条件表达式)
/*6、Replace Condition with Polymorphism(以多态取代条件表达式)
 
 现象：条件是对象的类型，根据对象的类型而选择不同的行为
 解决方案：将这个条件表达式的每个分支放进一个子类的覆写函数中，然后将原始函数声明为抽象函数
 */
//--------------------------重构前--------------------------
/*
class ConditionBook {
    static let NEW_BOOK = 0
    static let OLD_BOOK = 1
    static let CHIDREN_BOOK = 2
    
    var bookCode:Int
    var bookName:String
    
    init(_ bookCode:Int, _ bookName:String) {
        self.bookCode = bookCode
        self.bookName = bookName
    }
    
    func charge() -> Double {
        var result:Double = 0
        switch self.bookCode {
        case ConditionBook.NEW_BOOK:
            result += 10      //假设这里是一些超复杂的计算
        case ConditionBook.OLD_BOOK:
            result += 5       //假设这里是一些超复杂的计算
        case ConditionBook.CHIDREN_BOOK:
            result += 3       //假设这里是一些超复杂的计算
        default:
            break;
        }
        return result
    }
    
}
*/
//--------------------------重构后--------------------------
//使用多态进行重构
protocol Price {
    func charge()->Double
}
//关键是根据不同的书籍类型创建不同的书籍价格对象
class NewBookPrice:Price{
    func charge() -> Double {
        //假设这里是一些超复杂的计算
        return 10
    }
}
class OldBookPrice:Price{
    func charge() -> Double {
        //假设这里是一些超复杂的计算
        return 5
    }
}
class ChildrenBookPrice:Price{
    func charge() -> Double {
        //假设这里是一些超复杂的计算
        return 3
    }
}
class ConditionBook {
    static let NEW_BOOK = 0
    static let OLD_BOOK = 1
    static let CHIDREN_BOOK = 2
    
    var bookCode:Int = 0
    var bookName:String
    var price : Price? = nil
    
    init(_ bookCode:Int, _ bookName:String) {
        self.bookName = bookName
        self.setBookCode(bookCode)
    }
    
    private func setBookCode(_ bookCode : Int){
        self.bookCode = bookCode
        switch self.bookCode {
        case ConditionBook.NEW_BOOK:
            self.price = NewBookPrice()
        case ConditionBook.OLD_BOOK:
            self.price = OldBookPrice()
        case ConditionBook.CHIDREN_BOOK:
            self.price = ChildrenBookPrice()
        default:
            break;
        }
    }
    
    func charge() -> Double {
        return self.price!.charge()
    }
    
}
