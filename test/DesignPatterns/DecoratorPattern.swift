//
//  DecoratorPattern.swift
//  test
//
//  Created by Jialin Chen on 2019/7/4.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//https://www.cnblogs.com/ludashi/p/5355567.html

import UIKit

//MARK:------”装饰者模式“Decorator pattern
/*
 装饰者模式：动态的将责任附加到对象上，若要扩展功能，装饰者提供了比继承更有弹性的替代方案。
 另一种表达方式：对原有的物体进行装饰，给原有的物体添加上新的装饰品。
 
 装饰者 = 旧组件 + 新装饰品
 
 举例说明：
 好比我们往花瓶里插花，我们在插花的时候是不会对花瓶以及原来的花进行任何修改，而直管将我们新的花添加进花瓶即可。花瓶是 Component，鲜花是 Decorator。
 比如一个礼物，我们要对其进行包装，礼物是被装饰者 即 组件Component,而包装盒以及包装盒上的花等等就是装饰品 即 装饰者Decorator
 
 开放关闭原则：类应该对扩展开放，对修改关闭
 在不修改代码的情况下惊醒功能扩展
 */

//利用 多态 实现 装饰者模式
//装饰者对象 = 旧组件 + 新装饰品 = 新组件

//1、实现空花瓶的基类
//花瓶的基类
class VaseComponent{
    //对花瓶进行描述
    private var description : String
    
    init(_ description : String = "花瓶") {
        self.description = description
    }
    
    //获取description存储的描述信息
    func getDescription()->String{
        return self.description
    }
    
    func display(){
        //打印描述信息
        print(getDescription())
    }
}
//2、创建空花瓶
//创建特定的花瓶
class Porcelain : VaseComponent{
    init() {
        super.init("瓷花瓶：")
    }
}
class Glass : VaseComponent{
    init() {
        super.init("玻璃花瓶：")
    }
}
//3、鲜花基类的实现
//鲜花的父类，因为装饰者就是最新的花瓶组件，所以要继承自VaseComponent
class FlowerDecorator : VaseComponent{
    //用于存储 “旧组件” 即上次被装饰过的花瓶组件
    var vase : VaseComponent
    
    //“装饰者”在初始化时会指定上次被修饰后的组件（空花瓶或者其他修饰者的对象）
    init(_ vase : VaseComponent) {
        self.vase = vase
    }
}
//4、实现各个装饰者
//往花瓶里加入特定的花进行装饰
//玫瑰花
class Rose : FlowerDecorator{
    
    override init(_ vase: VaseComponent) {
        super.init(vase)
    }
    
    override func getDescription() -> String {
        return vase.getDescription() + "玫瑰 "
    }
}
//百合花
class Lily : FlowerDecorator{
    override init(_ vase: VaseComponent) {
        super.init(vase)
    }
    
    override func getDescription() -> String {
        return vase.getDescription() + "百合 "
    }
}

//MARK:=================示例2
///=================定义基类==========================
//饮料基类
class Beverage{
    var description : String
    
    init(_ description : String = "Unknow Beverage") {
        self.description = description
    }
    
    func getDescription()->String{
        return description
    }
    
    func cost()->Double{
        return 0.0
    }
}
//调料基类
class CondimenDecorator : Beverage{
    override func getDescription() -> String {
        return ""
    }
}

///=================实现不同的咖啡==============
/// 浓缩咖啡
class Espresso : Beverage{
    init() {
        super.init("浓缩咖啡")
    }
    
    override func cost() -> Double {
        return 1.99
    }
}

class HouseBlend : Beverage{
    init() {
        super.init("星巴克杜绝调理咖啡：综合咖啡")
    }
    
    override func cost() -> Double {
        return 0.99
    }
}
/// ============实现各种调料===========
///摩卡
class Mocha : CondimenDecorator{
    var beverage : Beverage
    init(_ beverage : Beverage) {
        self.beverage = beverage
    }
    
    override func getDescription() -> String {
        return "摩卡，"+beverage.getDescription()
    }
    
    override func cost() -> Double {
        return beverage.cost() + 0.29
    }
}
///牛奶
class Milk : CondimenDecorator{
    var beverage : Beverage
    init(_ beverage : Beverage) {
        self.beverage = beverage
    }
    
    override func getDescription() -> String {
        return "牛奶，"+beverage.getDescription()
    }
    
    override func cost() -> Double {
        return beverage.cost() + 0.79
    }
    
}
