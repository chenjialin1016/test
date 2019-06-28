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
 
 现象：从一个类中衍生出许多彼此相等的实例，希望将它们替换为同一个对象
 解决方案：将这个值改变成引用对象
 */
//--------------------------重构前--------------------------
/*
class Customer{
    private var name : String
    private var idCard : String
    
    init(_ name : String, _ idCard : String) {
        self.name = name
        self.idCard = idCard
    }
    
    func getName()->String{
        return name
    }
    func setName(_ name : String){
        self.name = name
    }
    func getIdCard()->String{
        return idCard
    }
}
class Order{
    private var customer : Customer
    
    init(_ customerName : String, idCard : String) {
        self.customer = Customer.init(customerName, idCard)
    }
    func setCustomer(_ customerName : String, idCard : String){
        self.customer = Customer.init(customerName, idCard)
    }
    func getCustomer()->Customer{
        return self.customer
    }
    func getCustomerName()->String{
        return self.customer.getName()
    }
    func setCustomerName(_ name : String){
        self.customer.setName(name)
    }
    func getCustomerIdCard()->String{
        return self.customer.getIdCard()
    }
    
}
*/
//--------------------------重构中--------------------------
/*
//将Order中Customer改为引用类型（重新设计Order类）
//其改变的是不仅仅是模块内部的结构，而且修改了模块的调用方式。也就是说里外都被修改了，这与我们重构所提倡的“改变模块内部结构，而不改变对外调用方式”所相悖
class Customer{
    private var name : String
    private var idCard : String
    
    init(_ name : String, _ idCard : String) {
        self.name = name
        self.idCard = idCard
    }
    
    func getName()->String{
        return name
    }
    func setName(_ name : String){
        self.name = name
    }
    func getIdCard()->String{
        return idCard
    }
}
class Order{
    private var customer : Customer
    
    init(_ customer : Customer) {
        self.customer = customer
    }
    func setCustomer(_ customer : Customer){
        self.customer = customer
    }
    func getCustomer()->Customer{
        return self.customer
    }
    func getCustomerName()->String{
        return self.customer.getName()
    }
    func setCustomerName(_ name : String){
        self.customer.setName(name)
    }
    func getCustomerIdCard()->String{
        return self.customer.getIdCard()
    }
    
}
*/
//--------------------------重构后--------------------------
//从根本上重构===创建Customer工厂，使order中的customer对象变成引用类型
/*
 重构的目标就是“不改变对外调用方式，但能保持每个用户是唯一的”
 1、首先对customer进行重构：在Customer中添加了一个静态的私有变量customers, 该静态私有变量是字典类型。其中存储的就是每次创建的消费者信息。在字典中每个消费者的key为消费者独一无二的身份证信息（idCard）。在添加完上述变量后，我们需要为创建一个工厂方法createCustomer() 在工厂方法中，如果当前传入的用户信息未被存入到字典中，我们就对其进行创建存入字典，并返回该用户信息。如果传入的用户已经被创建过，那么就从字典中直接取出用户对象并返回
 2、需要在order中通过工厂方法获取xustomer类的实例：这样就能保证Order中的customer对象也是引用对象了。不过此时的引用对象是从Customer中获取的，而不是外部传过来的。下方是Order类中对工厂方法的调用，这样做的好处就是，我们只对模块的内部进行了修改，而测试用例无需修改
 */
class Customer{
    private var name : String
    private var idCard : String
    static var customers : Dictionary<String, Customer> = Dictionary()
    
    init(_ name : String, _ idCard : String) {
        self.name = name
        self.idCard = idCard
    }
    
    func getName()->String{
        return name
    }
    func setName(_ name : String){
        self.name = name
    }
    func getIdCard()->String{
        return idCard
    }
    
    //工厂方法
    static func createCustomer(_ name : String, _ idCard : String)->Customer{
        guard let instance : Customer = Customer.customers[idCard] else {
            Customer.addCustomer(name, idCard)
            return Customer.createCustomer(name, idCard)
        }
        return instance
    }
    
    //添加用户
    static func addCustomer(_ name : String, _ idCard : String){
        Customer.init(name, idCard).store()
    }
    //存储用户
    private func store(){
        Customer.customers[self.getIdCard()] = self
    }
}
    
class Order{
    private var customer : Customer
    
    init(_ customerName : String, _ idCard : String) {
        self.customer = Customer.createCustomer(customerName, idCard)
    }
    func setCustomer(_ customerName : String, _ idCard : String){
        self.customer = Customer.createCustomer(customerName, idCard)
    }
    func getCustomer()->Customer{
        return self.customer
    }
    func getCustomerName()->String{
        return self.customer.getName()
    }
    func setCustomerName(_ name : String){
        self.customer.setName(name)
    }
    func getCustomerIdCard()->String{
        return self.customer.getIdCard()
    }
    
}

//MARK:===========4、 Change Reference to Value 将引用对象改为值对象
/*4、 Change Reference to Value------将引用对象改为值对象
 
 现象：你有一个引用对象，该对象很小而且不可变，不易统一管理
 解决方案：将引用对象改为值对象
 */
class Currency{
    private let code : String!
    
    init(_ code : String) {
        self.code = code
    }
    
    func getCode()->String{
        return self.code
    }
}
//Equatable，重载==
func ==(_ lhs : Currency, _ rhs : Currency)-> Bool{
    return lhs.getCode() == rhs.getCode()
}

//MARK:===========5、 Replace Array or Dictionary with Object 以对象取代数组/字典
/*5、 Replace Array or Dictionary with Object------以对象取代数组/字典
 与2是同一个
 
 现象：一个数组或者字典中元素代表不同的东西
 解决方案：使用对象来替换数组或者字典，以一个字段表示一个元素
 */
//--------------------------重构前--------------------------
let studentXiaoMing : Dictionary = ["name":"小明", "age":18] as [String : Any]
let studentArray : Array = ["小明", 18] as [Any]
//--------------------------重构后--------------------------
//将上述字典或者数组改成数据类
class Student{
    var name : String
    var age : UInt
    
    init(_ name : String, _ age : UInt) {
        self.name = name
        self.age = age
    }
}


//MARK:===========6、 Duplicate Observed Data 复制“被检测数据”（*****）
/*6、 Duplicate Observed Data------复制“被检测数据”
 
 现象：业务逻辑与GUI糅合在一起
 解决方案：将业务逻辑进行分离，分离后会用到事件监听或者属性观察
 */
//--------------------------重构前--------------------------
//例子见：AddViewController.swift

//--------------------------重构后--------------------------
//例子见：AddReviewViewController.swift

//MARK:===========7、 Change Unidirectional Association to Bidirectional 将单向关联改为双向关联
/*7、 Change Unidirectional Association to Bidirectional------方法迁移
 
 现象：两个类都需要使用对方的特性，但其间只有一条单向连接
 解决方案：添加一个反向指针，并修改函数能够同时更新两条链接
 */
//--------------------------重构前--------------------------
//参考3中的重构后的例子

//--------------------------重构后--------------------------
/*
 与之对应的规则是Change Bidirectional Association to Unidirectional(将双向关联改为单向关联)，就是根据特定需求删去一个链。就是说，原来需要双向链，可如今由于需求变更单向关联即可，那么你就应该将双向关联改为单向关联。
 */
class Customer1{
    private var name : String
    private var idCard : String
    static var customers : Dictionary<String, Customer1> = Dictionary()
    
    //添加与order关联的链，一个用户有多个订单
     var orders : Array<Order1> = []
    
    init(_ name : String, _ idCard : String) {
        self.name = name
        self.idCard = idCard
    }
    
    func getName()->String{
        return name
    }
    func setName(_ name : String){
        self.name = name
    }
    func getIdCard()->String{
        return idCard
    }
    
    //工厂方法
    static func createCustomer(_ name : String, _ idCard : String)->Customer1{
        guard let instance : Customer1 = Customer1.customers[idCard] else {
            Customer1.addCustomer(name, idCard)
            return Customer1.createCustomer(name, idCard)
        }
        return instance
    }
    
    //添加用户
    static func addCustomer(_ name : String, _ idCard : String){
        Customer1.init(name, idCard).store()
    }
    //存储用户
    private func store(){
        Customer1.customers[self.getIdCard()] = self
    }
    
    //============添加==============
    func addOrder(_ order : Order1){
        self.orders.append(order)
    }
    func getOrders()->Array<Order1>{
        return self.orders
    }
}

class Order1{
    private var customer : Customer1
    
    init(_ customerName : String, _ idCard : String) {
        self.customer = Customer1.createCustomer(customerName, idCard)
        self.customer.addOrder(self)
    }
    func setCustomer(_ customerName : String, _ idCard : String){
        self.customer = Customer1.createCustomer(customerName, idCard)
    }
    func getCustomer()->Customer1{
        return self.customer
    }
    func getCustomerName()->String{
        return self.customer.getName()
    }
    func setCustomerName(_ name : String){
        self.customer.setName(name)
    }
    func getCustomerIdCard()->String{
        return self.customer.getIdCard()
    }
    
}


//MARK:===========8、 Replace Magic Number with Synbolic Constant 以字面常量取代魔法数
/*8、 Replace Magic Number with Synbolic Constant------以字面常量取代魔法数
 
 现象：你有一个字面数值，带有特别含义
 解决方案：将该字面值存入一个使用其功能命名的常量中，并将该字面值量替换成该常量
 */
//--------------------------重构前--------------------------
func test(_ height : Double)->Double{
    return 3.141592654 * height
}

//--------------------------重构后--------------------------
//替换
let PI = 3.141592654
func test1(_ height : Double)->Double{
    return PI * height
}

//MARK:===========9、 Encapsulate Field 封装字段
/*9、 Encapsulate Field------封装字段
 
 现象：类中有字段为public类型
 解决方案：将该字段转换成private，然后添加访问方法 getter/setter
 原因：因为直接访问类的字段，会降低程序的模块化，不利于程序的扩充和功能的添加
 */
//--------------------------重构前--------------------------
/*
class Person {
    var name : String = ""
    
    init(_ name : String) {
        self.name = name
    }
}
*/
//--------------------------重构后--------------------------
class Person {
    private var name : String = ""
    
    init(_ name : String) {
        self.name = name
    }
    
    func getName()->String{
        return name
    }
    func setName(_ name : String){
        self.name = "China："+name
    }
}

//MARK:===========10、 Encapsulate Collection 封装集合
/*10、 Encapsulate Collection------封装集合
 
 现象：当类中有集合时
 解决方案：为了对该集合进行封装，你需要为集合创建相应的操作方法，例如增删改查
 */
//--------------------------重构前--------------------------
/*
class LibraryBook {
    private var name : String
    
    init(_ name : String) {
        self.name = name
    }
    func getName()->String{
        return self.name
    }
}
class Lender {
    private var name : String
    private var lendBooks : [LibraryBook] = [LibraryBook]()
    
    init(_ name : String) {
        self.name = name
    }
    func getName()->String{
        return self.name
    }
    func setLendBooks(_ books : [LibraryBook]){
        self.lendBooks = books
    }
    func getLendBooks()->[LibraryBook]{
        return self.lendBooks
    }
}
*/
//--------------------------重构后--------------------------
class LibraryBook {
    private var name : String
    
    init(_ name : String) {
        self.name = name
    }
    func getName()->String{
        return self.name
    }
}
class Lender {
    private var name : String
    private var lendBooks : [String:LibraryBook] = [String:LibraryBook]()
    
    init(_ name : String) {
        self.name = name
    }
    func getName()->String{
        return self.name
    }
    func getLendBooks()->[String:LibraryBook]{
        return self.lendBooks
    }
    
    //为相应的集合添加相应的操作方法
    func addBook(_ bookName : String){
        self.lendBooks[bookName] = LibraryBook(bookName)
    }
    func removeBook(_ bookName : String){
        self.lendBooks.removeValue(forKey: bookName)
    }
    func removeAll(){
        self.lendBooks.removeAll()
    }
}

//MARK:===========11、 Replace Subclass with Fields 以字段取代子类
/*11、 Replace Subclass with Fields------以字段取代子类
 
 现象：各个子类中唯一的差别只在“返回常量数据”函数上
 解决方案：修改这些函数，使他们返回超类中某个（新增）字段，然后销毁子类
 */
//--------------------------重构前--------------------------
/*
enum SenderCode : String {
    case Male = "M"
    case Female = "F"
}
//创建一个抽象类
protocol PersonType {
    func isMale()->Bool
    func getCode()->String
}
//基于personType创建两个子类
class Male : PersonType{
    func isMale() -> Bool {
        return true
    }
    func getCode() -> String {
        return SenderCode.Male.rawValue
    }
}
class Female: PersonType {
    func isMale() -> Bool {
        return false
    }
    func getCode() -> String {
        return SenderCode.Female.rawValue
    }
}
*/
//--------------------------重构后--------------------------
enum SenderCode : String {
    case Male = "M"
    case Female = "F"
}
//创建一个抽象类
class PersonType {
    private var isMale : Bool
    private var code : String
    
    init(_ isMale : Bool, _ code : String) {
        self.isMale = isMale
        self.code = code
    }
    
    func getIsMale()->Bool{
        return self.isMale
    }
    func getCode()->String{
        return self.code
    }
    
    //创建工厂方法
    static func createMale()->PersonType{
        return PersonType(true, SenderCode.Male.rawValue)
    }
    static func createFemale()->PersonType{
        return PersonType(false, SenderCode.Female.rawValue)
    }
}

