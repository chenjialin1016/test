//
//  DataReview.swift
//  test
//
//  Created by Jialin Chen on 2019/6/5.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import Foundation

//数据重构

//MARK:===========1、 Self Encapsulate Field 自封装字段
/*1、 Self Encapsulate Field------自封装字段
 自封装字段：虽然字段对外是隐藏的，但是还是有必要为其添加getter方法，在类的内部使用getter方法来代替self.field，该方式称为自封装字段，自己封装的字段，自己使用（即间接访问字段）
 
 现象：当直接访问字段时，增加了代码的耦合度
 解决方案：为字段提供setter/getter方法（直接访问->间接访问）
 */
//--------------------------重构前--------------------------
/*
class IntRange{
    private var low : Int
    private var high : Int
    
    init(_ low : Int, _ high : Int) {
        self.low = low
        self.high = high
    }
    
    func grow(_ factor: Int){
        self.high *= factor
    }
    
    func include(_ arg : Int)->Bool{
        return arg >= self.low && arg <= self.high
    }
}
*/
//--------------------------重构后--------------------------
//1、为IntRange类的字段添加setter和getter方法，但是该方法不能再构造函数中调用
class IntRange{
    private var low : Int
    private var high : Int
    
    //构造函数中不能使用自封装的函数
    init(_ low : Int, _ high : Int) {
        self.low = low
        self.high = high
    }
    
    func grow(_ factor: Int){
        setHigh(getHigh() * factor)
    }
    
    func include(_ arg : Int)->Bool{
        return arg >= getLow() && arg <= getHigh()
    }
    
    //setter/getter方法
    func setLow(_ low : Int){
        self.low = low
    }
    func getLow()->Int{
        return self.low
    }
    func setHigh(_ high : Int){
        self.high = high
    }
    func getHigh()->Int{
        return self.high
    }
}
//2、为InRange添加子类时，间接赋值的好处才会体现出来
class CappedRange : IntRange{
    private var cap : Int
    
    init(_ low : Int, _ high : Int, _ cap : Int) {
        self.cap = cap
        super.init(low, high)
    }
    func getCap()->Int{
        return self.cap
    }
    override func getHigh() -> Int {
        return min(super.getHigh(), getCap())
    }
}

//MARK:===========2、 Replace data Value with Object 以对象取代数据值
/*2、 Replace data Value with Object------以对象取代数据值
 model的职责就是将一些相关联的数据组织在一起来表示一个实体。model类比较简单
 
 现象：数据项在使用时与其他数据项进行组合出现才有意义
 解决方案：抽象成数据模型类，使用该数据模型来代替数据项组合
 */
class PersonModel{
    private var name : String
    private var birthday : String
    private var sender : String
    
    init(_ name : String, _ birthday : String, _ sender : String) {
        self.name = name
        self.birthday = birthday
        self.sender = sender
    }
    
    //setter/getter方法
    func getName()->String{
        return self.name
    }
    func getBirthday()->String{
        return self.birthday
    }
    func getSender()->String{
        return self.sender
    }
}

//MARK:===========3、 Change Value to Reference 将值对象改变成引用对象
/*3、 Change Value to Reference------将值对象改变成引用对象
 
 现象：
 解决方案：
 */
//--------------------------重构前--------------------------

//--------------------------重构后--------------------------

//MARK:===========4、 Change Reference to Value 将引用对象改为值对象
/*4、 Change Reference to Value------将引用对象改为值对象
 
 现象：
 解决方案：
 */
//--------------------------重构前--------------------------

//--------------------------重构后--------------------------

//MARK:===========5、 Replace Array or Dictionary with Object 以对象取代数组/字典
/*5、 Replace Array or Dictionary with Object------以对象取代数组/字典
 
 现象：
 解决方案：
 */
//--------------------------重构前--------------------------

//--------------------------重构后--------------------------

//MARK:===========6、 Duplicate Observed Data 复制“被检测数据”
/*6、 Duplicate Observed Data------复制“被检测数据”
 
 现象：
 解决方案：
 */
//--------------------------重构前--------------------------

//--------------------------重构后--------------------------

//MARK:===========7、 Change Unidirectional Association to Bidirectional 将单向关联改为双向关联
/*7、 Change Unidirectional Association to Bidirectional------方法迁移
 
 现象：
 解决方案：
 */
//--------------------------重构前--------------------------

//--------------------------重构后--------------------------

//MARK:===========8、 Replace Magic Number with Synbolic Constant 以字面常量取代魔法数
/*8、 Replace Magic Number with Synbolic Constant------以字面常量取代魔法数
 
 现象：
 解决方案：
 */
//--------------------------重构前--------------------------

//--------------------------重构后--------------------------

//MARK:===========9、 Encapsulate Field 封装字段
/*9、 Encapsulate Field------封装字段
 
 现象：
 解决方案：
 */
//--------------------------重构前--------------------------

//--------------------------重构后--------------------------

//MARK:===========10、 Encapsulate Collection 封装集合
/*10、 Encapsulate Collection------封装集合
 
 现象：
 解决方案：
 */
//--------------------------重构前--------------------------

//--------------------------重构后--------------------------

//MARK:===========11、 Replace Subclass with Fields 以字段取代子类
/*11、 Replace Subclass with Fields------以字段取代子类
 
 现象：
 解决方案：
 */
//--------------------------重构前--------------------------

//--------------------------重构后--------------------------


