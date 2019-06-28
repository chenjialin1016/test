//
//  ExtendsReview.swift
//  test
//
//  Created by Jialin Chen on 2019/6/27.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

//MARK:===========1、Pull Up Field (字段上移) & Pull Down Field (字段下移)
/*1、Pull Up Field (字段上移) 案例只介绍上移
 
 现象：两个子类拥有相同的字段
 解决方案：将字段移到超类中
 
 & Pull Down Field (字段下移)
 现象：父类中的某一个字段只有一个某一个子类使用到
 解决方案：将字段移到子类中
 */
//--------------------------重构前--------------------------
/*
class MySuperClass{
    
}
class SubClass1 : MySuperClass{
    var a = 0
}
class SubClass2 : MySuperClass{
    var a = 0
}
*/
//--------------------------重构后--------------------------
class MySuperClass{
    var a = 0
}
class SubClass1 : MySuperClass{
}
class SubClass2 : MySuperClass{
}

//MARK:===========2、Extract Subclass (提炼子类)
/*2、Extract Subclass (提炼子类)
 
 现象：类中的某个方法只有某些实例才可以用到
 解决方案：提炼出一个子类，将该方法放到子类中
 
 与“提炼子类”规则相对应的是“Collapse Hierarchy (折叠继承关系)”。
 一句话来概括：就是当你的父类与子类差别不大时，我们就可以将子类与父类进行合并。将上面的示例翻转就是“Collapse Hierarchy (折叠继承关系)”规则的示例
 
 Collapse Hierarchy (折叠继承关系)
 现象：父类和子类差别不大
 解决方案：将子类与父类进行合并
 */
//--------------------------重构前--------------------------
class CustomerBookOld{
    func otherSameMethod(){
    }
    func customeCharge()->Double{
        return 10
    }
    //只有vip用户在才会调用该方法
    func vipCharge()->Double{
        return self.customeCharge() * 0.7
    }
}

//--------------------------重构后--------------------------
class CustomerBook{
    func otherSameMethod(){
    }
    func customeCharge()->Double{
        return 10
    }
}
class VIPCustomerBook:CustomerBook{
    //只有vip用户在才会调用该方法
    func vipCharge()->Double{
        return self.customeCharge() * 0.7
    }
}

//MARK:===========3、Form Template Method (构造模板函数)
/*3、Form Template Method (构造模板函数)
 
 现象：不同类中的方法中大体步骤相同，具体细节不同
 解决方案：将细节进行封装，将步骤提取到父类中
 */
//--------------------------重构前--------------------------
/*
 class SuperClass0{
}
class SubCalass01 : SuperClass0{
    func calculate()->Double{
        let a : Double = 10 * 90 - 2
        let b : Double = 10 / 5 + 30
        return a + b //将设a+b为较为复杂的业务逻辑模版
    }
}
class SubCalass02 : SuperClass0{
    func calculate()->Double{
        let a : Double = 4 * 5 - 6
        let b : Double = 1 / 5 + 2
        return a + b
    }
}
*/
//--------------------------重构后--------------------------
class SuperClass{
    func calculateMethod()->Double{
        return getA() + getB()
    }
    func getA()->Double{
        return 0
    }
    func getB()->Double{
        return 0
    }
}
class Subcalass1 : SuperClass{
    override func getA() -> Double {
        return 10 * 90 - 2
    }
    override func getB() -> Double {
        return 10 / 5 + 30
    }
}
class Subcalass2 : SuperClass{
    override func getA() -> Double {
        return 4 * 5 - 6
    }
    override func getB() -> Double {
        return 1 / 5 + 2
    }
}


//MARK:===========4、以委托取代继承（Replace Inheritance with Delegation）
/*4、以委托取代继承（Replace Inheritance with Delegation）
 
 现象：子类只用到了父类的某些方法，而且没有继承父类的数据
 解决方案：将这种继承关系修改成委托代理关系
 
 以继承取代委托（Replace Delegation with Inheritance）
 现象：两个类为委托关系，并经常为接口编写许多及其简单的委托函数
 解决方案：将委托类继承受托类，与上面正好相反
 */
//--------------------------重构前--------------------------
/*
class MySuperClass04{
    var a : Int = 0
    var b : Int = 0
    
    func display(_ number : Int){
        print(number)
    }
}
class subClass041:MySuperClass04{
    var c : Int = 100
}
*/
//--------------------------重构后--------------------------
//将继承关系修改成委托代理关系
class MySuperClass04{
    var a : Int = 0
    var b : Int = 0
    
    func display(_ number : Int){
        print(number)
    }
}
class subClass041{
    var c : Int = 100
    
    //代理对象
    let superObject  = MySuperClass04()
    
    func display(_ number: Int) {
        self.superObject.display(number)
    }
}


//MARK:===========5、Pull Up Method (将函数上移)&Pull Down Method (将函数下移)
/*5、Pull Up Method (将函数上移)
 
 现象：两个子类拥有相同的字段函数
 解决方案：将函数移到超类中
 
 Pull Down Method (将函数下移)
 现象：父类中某个函数只有某一个子类使用
 解决方案：将函数移动到相应的子类中
 */
//--------------------------重构前--------------------------
class MySuperClass01{
    
}
class subClass011 : MySuperClass01{
    func sameFunction(){
    }
}
class subClass012 : MySuperClass01{
    func sameFunction(){
    }
}


//--------------------------重构后--------------------------
class MySuperClass02{
    func sameFunction(){
    }
}
class subClass021 : MySuperClass02{
}
class subClass022 : MySuperClass02{
}


//MARK:===========6、Pull Up Constructor Body (将构造器上移)
/*6、Pull Up Constructor Body (将构造器上移)
 
 现象：两个子类拥有相同的字段函数
 解决方案：将函数移到超类中
 在swift中必须这样做，必须调用父类d构造器对
 */
class MySuperClass03{
    var a : Int = 0
    var b : Int = 0
    init(_ a : Int, _ b : Int) {
        self.a = a
        self.b = b
    }
}
class subClass031 : MySuperClass03{
    var c : Int = 0
    init(_ a: Int, _ b: Int, _ c : Int) {
        self.c = c
        super.init(a, b)
    }
}
class subClass032 : MySuperClass03{
    var d : Int = 0
    init(_ a: Int, _ b: Int, _ d : Int) {
        self.d = d
        super.init(a, b)
    }
}
