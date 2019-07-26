//
//  FactoryPattern.swift
//  test
//
//  Created by Jialin Chen on 2019/7/12.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//https://www.cnblogs.com/ludashi/p/5379585.html

import UIKit

//MARK:------”工厂模式“ Factory Pattern
/*
工厂模式分类：
 1）简单工厂模式（Simple Factory Pattern）
 2）工厂模式方法（Factory Method Pattern）
 3）抽象工厂模式（Abstract Factory Pattern）
 
 工厂模式中的工厂负责生产“对象”，该工厂也就是对象的工厂。我们在使用工厂模式时，需要使用哪种类型的对象，我们就告诉“工厂”，工厂就会根据我们的指令来生产出相应类型的对象。
 
 应用场景：大部分是根据不同类型来生成不同对象时，就可以使用工厂模式来解决 即 将创建的对象的过程封装到工厂中来完成。
 
 
 */

//MARK:------1、创建无“兵工厂”的武器库
/*
 WeaponType是武器类型的接口（协议），其中有一个必须实现的方法就是fire()方法。AK、AWP、HK都实现了WeaponType协议。
 WeaponUser则是武器的使用者，WeaponUser与WeaponType当然是依赖关系
 */
protocol WeaponType{
    func fire() ->String
}
class AK:WeaponType{
    func fire() -> String {
        return "AK: fire"
    }
}
class AWP:WeaponType{
    func fire() -> String {
        return "AWP: fire"
    }
}
class HK:WeaponType{
    func fire() -> String {
        return "HK: fire"
    }
}
enum WeaponTypeEnumeration{
    case AK, HK, AWP
}
class WeaponUser{
    func fireWithType(_ weaponType:WeaponTypeEnumeration){
        var weapon : WeaponType
        switch weaponType {
        case .AK:
            weapon = AK()
        case .HK:
            weapon = HK()
        case .AWP:
            weapon = AWP()
        default:
            break
        }
        print(weapon.fire())
    }
}

//MARK:------2、简单工厂模式 simple Factory
/*
 使用简单工厂模式将变化的部分进行提取
 
 将变化进行封装：改造switch语句，将其封装到一个新的类中
 */
//简单工厂
class WeaponFactory{
    func createWeaponWithType(_ weaponType : WeaponTypeEnumeration)->WeaponType{
        var weapon : WeaponType
        switch weaponType {
        case .AK:
            weapon = AK()
        case .HK:
            weapon = HK()
        case .AWP:
            weapon = AWP()
        default:
            break
        }
        return weapon
    }
}
class WeaponUser2{
    var weaponFactory : WeaponFactory
    
    init(_ weaponFactory : WeaponFactory) {
        self.weaponFactory = weaponFactory
    }
    func fireWithType(_ weaponType:WeaponTypeEnumeration){
        let weapon : WeaponType = weaponFactory.createWeaponWithType(weaponType)
        print(weapon.fire())
    }
}

//MARK:------3、工厂方法模式 Factory Method Pattern
/*
 工厂方法模式：定义了一个创建对象的接口，但由子类决定要实例化的类是哪一个。工厂方法让类把实例化推迟到子类。
 //依赖倒置原则：要依赖抽象，不要依赖具体类
 
 “工厂方法模式”重点在于方法，利用继承关系，以及子类间的差异化类创建不同的武器类型。
 有一点需要注意，同一个工厂方法中生产的是同一系列的不同产品，比如美国造的各种武器，这一点与抽象工厂不同
 
 我们需要为上述功能添加新的需求。武器不仅仅有种类，还有生产厂家，我们要为武器添加生产厂家。比如美国造AK, 德国造AK。则我们的用户可以分为美国武器使用者（AmericaWeaponUser），德国武器使用者（GermanyWeaponUser）。
 在这种情况下，“简单工厂”模式已不再使用。所以我们要使用即将出场的“工厂方法模式”（Factory Method Pattern）和“策略模式”（Strategy Pattern）对上述示例进行扩充。
 
 这些工厂方法的实现位于WeaponUser的子类中，由子类来确定生产出什么种类的武器。这也就是上面工厂方法模式定义中所说的“将对象的实例化推迟到子类中”。
 */
//1、为武器添加装饰者
//使用装饰者模式为武器添加不同的装饰 即 生产厂商
class WeaponDecorator:WeaponType{
    var weapon : WeaponType! = nil
    init(_ weapon : WeaponType) {
        self.weapon = weapon
    }
    func fire() -> String {
        return self.weapon.fire()
    }
}
//添加德国厂商装饰
class GermanyDecorator : WeaponDecorator{
    override func fire() -> String {
        return "德国造："+self.weapon.fire()
    }
}
//添加美国厂商装饰
class AmericaDecorator:WeaponDecorator{
    override func fire() -> String {
        return "美国造："+self.weapon.fire()
    }
}
//2、武器用户接口的代码实现
protocol WeaponUser3 {
    func fireWithType(_ weaponType : WeaponTypeEnumeration)
    func createWeaponWithType(_ weaponType : WeaponTypeEnumeration)->WeaponType!
}
//为firewithtype添加默认实现
extension WeaponUser3{
    func fireWithType(_ weaponType : WeaponTypeEnumeration){
        let weapon : WeaponType = createWeaponWithType(weaponType)
        print(weapon.fire())
    }
}
//3、工厂方法的具体实现
//德国用户：德国制造
class GermanyWeaponUser : WeaponUser3{
    func createWeaponWithType(_ weaponType: WeaponTypeEnumeration) -> WeaponType! {
        var weapon : WeaponType
        
        switch weaponType {
        case .AK:
            weapon = GermanyDecorator(AK())
        case .HK:
            weapon = GermanyDecorator(HK())
        case .AWP:
            weapon = GermanyDecorator(AWP())
        }
        return weapon
    }
}
//美国用户：美国制造
class AmericaWeaponUser:WeaponUser3{
    func createWeaponWithType(_ weaponType: WeaponTypeEnumeration) -> WeaponType! {
        var weapon : WeaponType
        
        switch weaponType {
        case .AK:
            weapon = AmericaDecorator(AK())
        case .HK:
            weapon = AmericaDecorator(HK())
        case .AWP:
            weapon = AmericaDecorator(AWP())
        }
        return weapon
    }
}
//MARK:------4、抽象工厂模式 Abstract Factory Pattern
/*
 抽象工厂：提供一个接口，用于创建相关或依赖对象的家族，而不需要明确指定具体类。
 
 将3中的工厂方法模式 替换为 抽象方法模式
 */
//创建s抽象工厂（工厂接口）
protocol WeaponFactoryType {
    func createAK()->WeaponType
    func createAWP()->WeaponType
    func createHK()->WeaponType
}
//美国兵工厂：生产 美国造 系列的武器
class AmericanWeaponFactory:WeaponFactoryType{
    func createAK() -> WeaponType {
        return AmericaDecorator(AK())
    }
    
    func createAWP() -> WeaponType {
        return AmericaDecorator(HK())
    }
    
    func createHK() -> WeaponType {
        return AmericaDecorator(AWP())
    }
}
//德国兵工厂：生产 德国造 系列的武器
class GermangWeaponFactory:WeaponFactoryType{
    func createAK() -> WeaponType {
        return GermanyDecorator(AK())
    }
    
    func createAWP() -> WeaponType {
        return GermanyDecorator(HK())
    }
    
    func createHK() -> WeaponType {
        return GermanyDecorator(AWP())
    }
}
//实现完工厂后，我们要修改武器的使用用户。因为在“工厂方法”模式中，不同工厂武器的选择是在用户的子类中实现的，而在“抽象工厂”中就使用不到子类了
class WeaponUser4{
    var factory : WeaponFactoryType
    init(_ factory : WeaponFactoryType) {
        self.factory = factory
    }
    
    func setFactory(_ factory : WeaponFactoryType){
        self.factory = factory
    }
    func fireWithType(_ weaponType : WeaponTypeEnumeration){
        var weapon : WeaponType
        
        switch weaponType {
        case .AK:
            weapon = factory.createAK()
        case .HK:
            weapon = factory.createHK()
        case .AWP:
            weapon = factory.createAWP()
        }
        print(weapon.fire())
    }
}

//MARK:------5、抽象工厂模式 + 装饰者 + 工厂方法
//使用工厂方法模式 来重写武器的使用者WeaponUser4：将WeaponUser4类中选择工厂的代码推迟到了相应的子类中，有子类的工厂方法来完成相应工厂的创建。
protocol WeaponUserType {
    func fireWithType(_ weaponType : WeaponTypeEnumeration)
    func createWeaponWithType(_ weaponType : WeaponTypeEnumeration)->WeaponType!
    
    //工厂方法
    func createWeaponFactory()->WeaponFactoryType
}
//为上述接口提供默认的方法
extension WeaponUserType{
    func fireWithType(_ weaponType : WeaponTypeEnumeration){
        let weapon : WeaponType = createWeaponWithType(weaponType)
        print(weapon.fire())
    }
    func createWeaponWithType(_ weaponType : WeaponTypeEnumeration)->WeaponType!{
        var weapon : WeaponType
        
        switch weaponType {
        case .AK:
            weapon = createWeaponFactory().createAK()
        case .HK:
            weapon = createWeaponFactory().createHK()
        case .AWP:
            weapon = createWeaponFactory().createAWP()
        }
        
        return weapon
    }
}
//要实现相应的WeaponUserType的子类，在子类中通过“工厂方法”来指定兵工厂
class AmericanWeaponUser5:WeaponUserType{
    func createWeaponFactory() -> WeaponFactoryType {
        return AmericanWeaponFactory()
    }
}
class GermanyWeaponUser5:WeaponUserType{
    func createWeaponFactory() -> WeaponFactoryType {
        return GermangWeaponFactory()
    }
}


//MARK:------实例2 披萨
//MARK:------1、无工厂的披萨
//pizza的种类
protocol PizzaType {
    func description()
}
class CheesePizza : PizzaType{
    func description() {
        print("CheesePizza")
    }
}
class GreekPizza : PizzaType{
    func description() {
        print("GreekPizza")
    }
}
class PepperoniPizza : PizzaType{
    func description() {
        print("PepperoniPizza")
    }
}
//pizza的类型枚举
enum PizzaTypeEnumeration{
    case Cheese, Greek, Pepperoni
}
class PizzaStore {
    func orderPizza(_ type : PizzaTypeEnumeration){
        var pizza : PizzaType
        
        switch type {
        case .Cheese:
            pizza = CheesePizza()
        case .Greek:
            pizza = GreekPizza()
        case .Pepperoni:
            pizza = PepperoniPizza()
        }
        pizza.description()
    }
}

//需求：现在需要增加Pizza的种类，如果直接修改OrderPizza，会违背 对扩展开放，修改关闭的原则，所以需要封装 改变的部分
//MARK:------2、简单工厂模式
class ClamPizza : PizzaType{
    func description() {
        print("ClamPizza")
    }
}
class VeggiePizza : PizzaType{
    func description() {
        print("VeggiePizza")
    }
}
enum PizzaTypeEnumeration2{
    //去掉了greek，增加了clam、veggie种类
    case Cheese, Pepperoni, Clam, Veggie
}
//将switch变化的部分封装为 简单工厂模式
class SimplePizzaFactory{
    func createPizza(_ type : PizzaTypeEnumeration2)->PizzaType{
        var pizza : PizzaType
        switch type {
        case .Cheese:
            pizza = CheesePizza()
        case .Pepperoni:
            pizza = PepperoniPizza()
        case .Clam:
            pizza = ClamPizza()
        case .Veggie:
            pizza = VeggiePizza()
        }
        return pizza
    }
}
//重做pizzastore 类
class PizzaStore2 {
    
    //创建简单工厂的引用
    var factory : SimplePizzaFactory
    
    //初始化简单工厂
    init(_ factory : SimplePizzaFactory) {
        self.factory = factory
    }
    
    func orderPizza(_ type : PizzaTypeEnumeration2){
        var pizza : PizzaType
        
        //通过简单工厂对象传入pizza类型
        pizza = factory.createPizza(type)
        
        pizza.description()
    }
}
//MARK:------3、工厂方法模式
//需求：由于披萨店经营有成，大家希望自家附近能有加盟店，但是每个地区的提供的披萨类型有所差异，如果利用简答工厂模式推广，会有一个问题就是 确实是采用你的工厂模式创建披萨，而采用的流程确是他们自创的，
//我们希望能够建立一个框架，把加盟店和创建披萨捆绑在一起的同时又保持一定的弹性，意思就是披萨的口类类型可以不一致，但是余下的烘烤、切片等步骤需要一致
//披萨增加装饰
class PizzaTypeDecorator:PizzaType{
    
    
    var pizza : PizzaType? = nil
    init(_ pizza : PizzaType) {
        self.pizza = pizza
    }
    
    func description() {
        self.pizza!.description()
    }
}
//纽约风味披萨
class NYPizzaDecorator : PizzaTypeDecorator{
    override func description() {
        print("纽约风味：")
        self.pizza?.description()
    }
}

//芝加哥风味披萨
class ZJGPizzaDecorator : PizzaTypeDecorator{
    override func description() {
        print("芝加哥风味：")
        self.pizza?.description()
    }
}

protocol PizzaStore3 {
    func orderPizza(_ type : PizzaTypeEnumeration2)
    func createPizza(_ type : PizzaTypeEnumeration2)->PizzaType
}
//实现orderPizza的默认实现
extension PizzaStore3{
    func orderPizza(_ type : PizzaTypeEnumeration2){
        var pizza : PizzaType
        pizza = createPizza(type)
        
        pizza.description()
    }
}
//让子类决定如何制造披萨
class NYStylePizzaStore:PizzaStore3{
    func createPizza(_ type: PizzaTypeEnumeration2) -> PizzaType {
        var pizza : PizzaType
        switch type {
        case .Cheese:
            pizza = NYPizzaDecorator.init(CheesePizza())
        case .Pepperoni:
            pizza = NYPizzaDecorator.init(PepperoniPizza())
        case .Clam:
            pizza = NYPizzaDecorator.init(ClamPizza())
        case .Veggie:
            pizza = NYPizzaDecorator.init(VeggiePizza())
        }
        return pizza
    }
}
class ZJGStylePizzaStore:PizzaStore3{
    func createPizza(_ type: PizzaTypeEnumeration2) -> PizzaType {
        var pizza : PizzaType
        switch type {
        case .Cheese:
            pizza = ZJGPizzaDecorator.init(CheesePizza())
        case .Pepperoni:
            pizza = ZJGPizzaDecorator.init(PepperoniPizza())
        case .Clam:
            pizza = ZJGPizzaDecorator.init(ClamPizza())
        case .Veggie:
            pizza = ZJGPizzaDecorator.init(VeggiePizza())
        }
        return pizza
    }
}
//MARK:------4、抽象工厂模式
//问题：一些加盟店使用低价原料来增加利润，你需要采取一些措施，避免长此以往毁了披萨的品牌
//需求：需要确保原料的一致，所以需要建造原料工厂，这个工厂复杂创建原料家族中的每一种原料
//抽象原料工厂
protocol PizzaIngredientFactory {
    func createCheese()->PizzaType
    func createVeggie()->PizzaType
    func createPepperoni()->PizzaType
    func createClam()->PizzaType
}
//创建纽约原料工厂
class NYPizzaIngredientFactory : PizzaIngredientFactory{
    func createCheese() -> PizzaType {
        return NYPizzaDecorator.init(CheesePizza())
    }
    
    func createVeggie() -> PizzaType {
        return NYPizzaDecorator.init(VeggiePizza())
    }
    
    func createPepperoni() -> PizzaType {
        return NYPizzaDecorator.init(PepperoniPizza())
    }
    
    func createClam() -> PizzaType {
        return NYPizzaDecorator.init(ClamPizza())
    }
}
//创建芝加哥原料工厂
class ZJGPizzaIngredientFactory : PizzaIngredientFactory{
    func createCheese() -> PizzaType {
        return ZJGPizzaDecorator.init(CheesePizza())
    }
    
    func createVeggie() -> PizzaType {
        return ZJGPizzaDecorator.init(VeggiePizza())
    }
    
    func createPepperoni() -> PizzaType {
        return ZJGPizzaDecorator.init(PepperoniPizza())
    }
    
    func createClam() -> PizzaType {
        return ZJGPizzaDecorator.init(ClamPizza())
    }
}
//披萨店
class PizzaStore4{
    var factory : PizzaIngredientFactory
    
    init(_ factory : PizzaIngredientFactory) {
        self.factory = factory
    }
    
    func setFactory(_ factory:PizzaIngredientFactory){
        self.factory = factory
    }
    
    private func createPizza(_ type: PizzaTypeEnumeration2) -> PizzaType {
        var pizza : PizzaType
        switch type {
        case .Cheese:
            pizza = factory.createCheese()
        case .Pepperoni:
            pizza = factory.createPepperoni()
        case .Clam:
            pizza = factory.createClam()
        case .Veggie:
            pizza = factory.createVeggie()
        }
        return pizza
    }
    
    func orderPizza(_ type : PizzaTypeEnumeration2){
        var pizza : PizzaType
        pizza = createPizza(type)
        
        pizza.description()
    }
}

