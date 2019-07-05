//
//  StrategyPattern.swift
//  test
//
//  Created by Jialin Chen on 2019/7/2.
//  Copyright © 2019年 Jialin Chen. All rights reserved.

//https://www.cnblogs.com/ludashi/p/5302269.html

import UIKit

//MARK:------穿越火线中的“策略模式（Strategy Pattern）”
/*
 策略模式：将不同的策略（算法）进行封装，让他们之间可以相互的替换，此模式让测试的变化独立于试用策略的用户
 
 策略模式图示中：
 在上面的类“类图”中我们对可变的“武器策略进行了提取”。我们使用了WeaponBehavior协议来规定武器的策略，使得不同的武器对外有统一的接口，在此就是使用武器，也就是开火。不同的武器使用不同的的“开火策略”，但是对外的接口都是一样的。设计原则中有一条是“面向接口编程，而不是面向实现编程”。这里所指的接口可以是协议，可以是抽象类，也可以是超类，其实就是利用面向对象的“多态”特性。上面的红框中实现的就是所有不同的策略。
 
 而绿框中是我们的用户，也就是军官的定义，是我们不变的部分。在军官中也有一个基类，在基类中定义了军官的共性，其中依赖于“武器策略”的接口。在军官超类中使用“武器策略”的协议声明了一个对象，该对象就是该军官所采取的武器策略。在军官的超类中可以通过setWeapon()方法采取不同的策略，其中fire()方法就是使用该“武器策略”进行开火。在具体的军官中的changeXXX()方法就是调用setWeapon()方法进行策略切换的方法。
 */

//MARK:------案例1
//模拟穿越火线中角色和武器的关系

//实现角色可以使用的不同的攻击行为，也就是不同的攻击策略
//武器策略
protocol WeaponBehavior {
    func useWeapon()
}
class AWPBeahavior : WeaponBehavior{
    func useWeapon() {
        print("大狙-----biu～biu～")
    }
}
class HK48Behavior : WeaponBehavior{
    func useWeapon() {
        print("HK48-----tu～tu～tu～")
    }
}
class PistolBehavior : WeaponBehavior {
    func useWeapon() {
        print("手枪-----pa～pa～pa～")
    }
}

//军官模块
class CharacterMan{
    //默认配备的是手枪
    private var weapon : WeaponBehavior! = PistolBehavior()
    
    func setWeapon(_ weapon : WeaponBehavior){
        self.weapon = weapon
    }
    
    //换手枪
    func changePistol(){
        self.setWeapon(PistolBehavior())
    }
    
    func fire(){
        guard self.weapon != nil else{
            return
        }
        self.weapon.useWeapon()
    }
}
//中尉只配备了手枪和hk48
class Lieutenant : CharacterMan{
    override init() {
        super.init()
    }
    
    //切换武器（策略）：换hk
    func changeHK(){
        self.setWeapon(HK48Behavior())
    }
}
//上尉只配备了手枪和大狙
class Captain : CharacterMan{
    override init() {
        super.init()
    }
    //切换武器（策略）：换大狙
    func changeAWP(){
        self.setWeapon(AWPBeahavior())
    }
}


//MARK:------案例2 鸭子
//MARK:------使用设计模式前------
/*
 class Duck{
    func swim(){
        print("鸭子游泳喽～")
    }
    
    func quack(){
        print("鸭子呱呱叫")
    }
    
    func display(){
    }
}
class MallarDuck : Duck{
    override func display() {
        print("我是绿头鸭子")
    }
}
class RedHeadDuck:Duck{
    override func display() {
        print("我是红头鸭子")
    }
}
class RubberDuck:Duck{
    override func display() {
        print("橡皮鸭")
    }
}
*/
/*
 现在想要为某些鸭子添加上飞的方法，该如何去做呢？
 一些假的鸭子是不能飞的
 1、在基类中r添加fly()，在不会飞的鸭子中重新fly，但是这样的话，子类中会有些无用的方法
 2、使用接口，需要实现fly()的鸭子，实现接口即可，但是会产生重复的代码
 */

//MARK:------鸭子：解决方案1:使用swift的协议延展来做------
/*
protocol Flyable {
    func fly()
}
extension Flyable{
    func fly(){
        print("我是会飞的鸭子，我用翅膀飞")
    }
}
class Duck{
    func swim(){
        print("鸭子游泳喽～")
    }
    
    func quack(){
        print("鸭子呱呱叫")
    }
    
    func display(){
    }
}
//用绿头鸭实现会飞的功能
class MallarDuck : Duck, Flyable{
    override func display() {
        print("我是绿头鸭子")
    }
}
class RedHeadDuck:Duck{
    override func display() {
        print("我是红头鸭子")
    }
}
class RubberDuck:Duck{
    override func display() {
        print("橡皮鸭")
    }
}
*/
//MARK:------鸭子：解决方案2:使用多态、行为代理即“策略模式”------
/*
 设计原则：
 1、找出应用中可能需要变化之处，把它们独立出来，不要和那些不变的代码混在一起
 2、针对接口编程，而不是针对实现编程
 3、多用组合，少用继承
 */

//飞的行为协议
protocol Flyable {
    func fly()
}
//使用翅膀飞的类
class FlyWithWings:Flyable{
    func fly() {
        print("我是会飞的鸭子，我用翅膀飞呀飞")
    }
}
//什么都不会飞
class FlyNoWay:Flyable{
    func fly() {
        print("我是不会飞的鸭子")
    }
}
class Duck{
    //添加行为委托代理者
    var flyBehavior : Flyable! = nil
    
    func setFlyBehavior(_ flyBehavior : Flyable){
        self.flyBehavior = flyBehavior
    }
    func swim(){
        print("鸭子游泳喽～")
    }
    
    func quack(){
        print("鸭子呱呱叫")
    }
    
    func display(){
    }
    
    //执行飞的行为
    func performFly(){
        guard self.flyBehavior != nil else {
            return
        }
        self.flyBehavior.fly()
    }
}
//用绿头鸭实现会飞的功能
class MallarDuck : Duck{
    override init() {
        super.init()
        self.setFlyBehavior(FlyWithWings())
    }
    override func display() {
        print("我是绿头鸭子")
    }
}
class RedHeadDuck:Duck{
    override init() {
        super.init()
        self.setFlyBehavior(FlyWithWings())
    }
    override func display() {
        print("我是红头鸭子")
    }
}
class RubberDuck:Duck{
    override init() {
        super.init()
        self.setFlyBehavior(FlyNoWay())
    }
    override func display() {
        print("橡皮鸭")
    }
}
//MARK:------鸭子：需求增加：增加模型鸭子，且会飞------
//在上面的基础上进行扩充是非常简单的
class ModelDuck : Duck{
    override init() {
        super.init()
        self.setFlyBehavior(FlyWithWings())
    }
    override func display() {
        print("鸭子模型")
    }
}
//MARK:------鸭子：需求增加：给模型鸭子装发动机，支持他飞------
class FlyAutomaticPower : Flyable{
    func fly() {
        print("我是用发动机飞的鸭子")
    }
}
