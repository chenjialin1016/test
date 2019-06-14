//
//  ClassReview.swift
//  test
//
//  Created by  on 2019/6/4.
//  Copyright © 2019年 . All rights reserved.
//

import Foundation
//类重构

//MARK:===========1、 Move Method 方法迁移
/*1、 Move Method------方法迁移
 
 现象：一个类中的函数与另一个类有很多的交互，函数非常依赖于某个类，如果一个类有太多行为，或与另一个类有太多合作而形成高度耦合
 解决方案：将该方法搬移到其高度耦合的类中
 */
//--------------------------重构前--------------------------
/*
class Book{
    static let NEW_BOOK = 0
    static let OLD_BOOK = 1
    static let CHILDREN_BOOK = 2
    
    var bookCode : Int
    var bookName : String
    
    init(_ bookCode : Int, _ bookName : String) {
        self.bookCode = bookCode
        self.bookName = bookName
    }
}
class BookCustomer{
    let name : String
    let isVip : Bool
    var books : [Book] = []
    
    init(_ name : String, _ isVip : Bool) {
        self.name = name
        self.isVip = isVip
    }
    
    func charge()->Double{
        var result : Double = 0
        
        for book in books {
            var singal : Double = 0
            switch book.bookCode{
            case Book.NEW_BOOK:
                singal += 10
            case Book.OLD_BOOK:
                singal += 5
            case Book.CHILDREN_BOOK:
                singal += 3
            default:
                break
            }
            result += singal
        }
        
        if isVip {
            result *= 0.7
        }else{
            result *= 0.9
        }
        return result
    }
}
*/
//--------------------------重构中--------------------------
/*
//1、charge函数太长了，而且switch的业务逻辑全是book的东西，与当前类无关联，但又是charge函数的核心，即bookcustomer严重依赖book的地方，所以将switch语句块放在book类中，将switch代码进行搬移
class Book{
    static let NEW_BOOK = 0
    static let OLD_BOOK = 1
    static let CHILDREN_BOOK = 2
    
    var bookCode : Int
    var bookName : String
    
    init(_ bookCode : Int, _ bookName : String) {
        self.bookCode = bookCode
        self.bookName = bookName
    }
    //将BookCustomer类中charge函数的switch部分搬移到Book类中
    func charge()->Double{
        var result : Double = 0
        switch self.bookCode{
        case Book.NEW_BOOK:
            result += 10
        case Book.OLD_BOOK:
            result += 5
        case Book.CHILDREN_BOOK:
            result += 3
        default:
            break
        }
        return result
    }
        
}
class BookCustomer{
    let name : String
    let isVip : Bool
    var books : [Book] = []
    
    init(_ name : String, _ isVip : Bool) {
        self.name = name
        self.isVip = isVip
    }
    
    func charge()->Double{
        var result : Double = 0
        
        for book in books {
            result += book.charge()
        }
        
        if isVip {
            result *= 0.7
        }else{
            result *= 0.9
        }
        return result
    }
}
*/
//--------------------------重构后--------------------------
//2、使用函数重构 Extract Method和Replace Temp With Qurey进行重构
class Book{
    static let NEW_BOOK = 0
    static let OLD_BOOK = 1
    static let CHILDREN_BOOK = 2
    
    var bookCode : Int
    var bookName : String
    
    init(_ bookCode : Int, _ bookName : String) {
        self.bookCode = bookCode
        self.bookName = bookName
    }
    //将BookCustomer类中charge函数的switch部分搬移到Book类中
    func charge()->Double{
        var result : Double = 0
        switch self.bookCode{
        case Book.NEW_BOOK:
            result += 10
        case Book.OLD_BOOK:
            result += 5
        case Book.CHILDREN_BOOK:
            result += 3
        default:
            break
        }
        return result
    }
    
}
class BookCustomer{
    let name : String
    let isVip : Bool
    var books : [Book] = []
    
    init(_ name : String, _ isVip : Bool) {
        self.name = name
        self.isVip = isVip
    }
    
    func charge()->Double{
        return getVipCharge(getBasePrice())
    }
    
    func getBasePrice()->Double{
        var result : Double = 0
        
        for book in books {
            result += book.charge()
        }
        return result
    }
    func getVipCharge(_ basePrice : Double)->Double{
        if isVip {
            return basePrice * 0.7
        }else{
            return basePrice * 0.9
        }
    }
}

//MARK:===========2、 Move Fileld 搬移字段
/*2、 Move Fileld------搬移字段
 
 现象：当在一个类中的某一个字段，被另一个类的对象频繁使用时，我们就应该考虑将这个字段的位置进行更改了
 解决方案：将这个字段的位置进行更改
 */

//MARK:===========3、 Extract class 提炼类
/*3、 Extract class------提炼类
 
 现象：一个类如果过于复杂，做了好多的事情，违背了“单一职责”的原则 / 某个类做了应该由 两个类 做的事
 解决方案：需要将其可以独立的模块进行拆分，当然有可能拆分出多个类，对类的细化也是为了减少代码的重复性，以及提高代码的复用性 / 创建一个新类，将相关的字段和函数从旧类搬移到新类
 */
//--------------------------重构前--------------------------
/*
class Employee{
    let name : String
    var officeAreaCode : String
    var officeNumber : String
    
    init(_ name : String, _ officeAreaCode : String, _ officeNumber : String) {
        self.name = name
        self.officeAreaCode = officeAreaCode
        self.officeNumber = officeNumber
    }
}
*/
//--------------------------重构后--------------------------
//重构，提取电话号码信息，使用 Extract class
class TelPhoneNumber{
    var areaCode : String
    var number : String
    
    init(_ areaCode : String, _ number : String) {
        self.areaCode = areaCode
        self.number = number
    }
}
class Employee{
    let name : String
    var officeTelphoneNumber : TelPhoneNumber
    
    init(_ name : String, _ officeTelphoneNumber : TelPhoneNumber) {
        self.name = name
        self.officeTelphoneNumber = officeTelphoneNumber
    }
    func getOfficeAreaCode()->String{
        return officeTelphoneNumber.areaCode
    }
    func getOfficeNumber()->String{
        return officeTelphoneNumber.number
    }
}

//MARK:===========4、 Inline Class 内联类
/*4、 Inline Class-----内联类
 
 现象：过度使用extract class 原则，会使得某些类过于简单并且调用该简单的类地方极少
 解决方案：通过 inline class 将过度抽象的类放到其他类中
 */

//MARK:===========5、 Hide Delegate 隐藏“委托关系”
/*5、 Hide Delegate------隐藏“委托关系”
 
 现象：客户通过一个委托类来调用另一个对象
 解决方案：在服务类上建立客户所需的所有函数，用以隐藏委托关系
 
 Remove Middle Man(移除中间人)原则: 与Hide Delegate相反，就是没有必要将委托人进行隐藏，所以就使用Remove Middle Man原则将上面我们封装的获取委托人的方法进行移除
 */
//--------------------------重构前--------------------------
/*
class Department{
    var  chargeCode : String             //部门代码
    var manager : People!                //经理
    
    init(_ chargeCode : String, _ manager : People!) {
        self.chargeCode = chargeCode
        self.manager = manager
    }
}
class People{
    var name : String
    var department : Department            //该人所在部门
    
    init(_ name : String, _ department : Department) {
        self.name = name
        self.department = department
    }
}
 */
//--------------------------重构后--------------------------
//在people中创建一个委托函数，以隐藏掉people对department的委托关系
class Department{
    var  chargeCode : String             //部门代码
    var manager : People!                //经理
    
    init(_ chargeCode : String, _ manager : People!) {
        self.chargeCode = chargeCode
        self.manager = manager
    }
}
class People{
    var name : String
    private var department : Department            //该人所在部门，私有化，进行隐藏
    
    init(_ name : String, _ department : Department) {
        self.name = name
        self.department = department
    }
    
    func getManager()->People{
        return self.department.manager
    }
}

//MARK:===========6、 Introduce Foreign Method 引入外加函数
/*6、 Introduce Foreign Method------引入外加函数
 
 现象：想要为类增加新的方法，但是又不能修改类
 解决方案：使用扩展能很好解决
 */
//--------------------------重构前--------------------------
class MyTest{
    static func method1(){
        print("method1")
    }
}
//--------------------------重构后--------------------------
//使用扩展增加新的方法
extension MyTest{
    static func method2(){
        print("扩展增加 method2")
    }
}
