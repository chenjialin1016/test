//
//  ObservePattern.swift
//  test
//
//  Created by Jialin Chen on 2019/7/2.
//  Copyright © 2019年 Jialin Chen. All rights reserved.

//https://www.cnblogs.com/ludashi/p/5308003.html

import UIKit

//MARK:------”观察者模式“实现通知机制
 /*
 观察者模式：观察者设计模式定义了对象间的一种一对多的依赖关系，以便一个对象的状态发生变化时，所有依赖于它的对象都得到通知并且自动刷新
 
 举例说明：比如老板在一个办公室里开会，办公室里有部分员工，在办公室的员工就是Observer（观察者），正在开会的老板就是Subject（主题：负责发送通知---Post Notification）。如果其他员工也想成为Observer，那么必须得进入（addObserver）正在开会的会议室成为观察者。员工成功观察者后收到通知得做一些事情吧（doSomething），比如记个笔记神马的。如果此时员工闹情绪，不想听老板开会了，于是通过removeObserver走出了会议室。上面这个过程其实就是观察者模式。
 
 设计原则：为了交互对象之间的松耦合设计而努力
 */


//基类
class ObserverType{
    
    //发布的消息
    var info : String = ""
    func update(_ info : String){}
    func display(){}
}
class SubjectType{
    var observersArray : [ObserverType] = [ObserverType]()
    var info : String = ""
    //注册观察者
    func registerObserver(_ observer : ObserverType){}
    //移除观察者
    func removeObserver(_ observer : ObserverType){}
    //通知观察者
    func notifyObserver(){}
}
//boss负责发送通知，coder和pm负责监听boss的通知
//发出通知的人，也就是通知中心，大Boss
class Boss : SubjectType{
    func setInfo(_ info : String){
        if info != self.info {
            self.info = info
            self.notifyObserver()
        }
    }
    
    override func registerObserver(_ observer: ObserverType) {
        self.removeObserver(observer)
        self.observersArray.append(observer)
    }
    
    override func removeObserver(_ observer: ObserverType) {
        for i in 0..<self.observersArray.count {
            if type(of: observersArray[i]) == type(of: observer){
                self.observersArray.remove(at: i)
                break
            }
        }
    }
    override func notifyObserver() {
        for observer : ObserverType in self.observersArray {
            observer.update(self.info)
        }
    }
}
//程序员
class Coder : ObserverType{
    override func update(_ info: String) {
        self.info = info
        display()
    }
    override func display() {
        print("程序员收到：\(self.info)")
    }
}
//产品经理
class PM : ObserverType{
    override func update(_ info: String) {
        self.info = info
        display()
    }
    override func display() {
        print("产品经理收到：\(self.info)")
    }
}

//MARK:------”观察者模式“实现气象站
//主题接口
protocol Subject{
    func registerObserver(_ observer : Observer)
    func removeObserver(_ observer : Observer)
    //当主题状态改变时，这个方法会被调用，以通知所有的观察者
    func notifyObservers()
}
//观察者接口
protocol Observer {
    //当气象观测值改变时，主题会把这些状态值当作方法的参数，传送给观察者
    /*
     问题：把观测值作为参数是很好的做法吗？
     */
    func update(_ temp : Float, _ humidity : Float, _ pressure : Float)
}
//布告板展示接口
protocol DisplayElement {
    //当布告板需要显示时，调用此方法
    func display()
}
//weatherData类实现主题接口
class WeatherData : Subject{
    //记录观察者的数组
    var observers : [Observer]
    private var temperature : Float!
    private var humidity : Float!
    private var pressure : Float!
    
    init() {
        observers = [Observer]()
    }
    
    func registerObserver(_ observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: Observer) {
        for i in 0..<observers.count {
            if type(of: observers[i]) == type(of: observer){
                observers.remove(at: i)
                break
            }
        }
    }
    
    func notifyObservers() {
        for i in 0..<observers.count {
            let observer = observers[i]
            observer.update(temperature, humidity, pressure)
        }
    }
    
    //当从气象站得到更新观测值时，通知观察者
    func measurementsChanged(){
        notifyObservers()
    }
    func setMeasurements(_ temperature : Float, _ humidity : Float, _ pressure : Float){
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        measurementsChanged()
    }
    
}

//布告板
class CurrentConditionsDisplay:Observer,DisplayElement{
    private var temperature : Float!
    private var humidity : Float!
    private var weatherData : Subject
    
    init(_ weatherData : Subject) {
        self.weatherData = weatherData
        weatherData.registerObserver(self)
    }
    
    func update(_ temp: Float, _ humidity: Float, _ pressure: Float) {
        self.temperature = temp
        self.humidity = humidity
        display()
    }
    
    func display() {
        print("目前状况布告板：\(self.temperature) F degress and \(self.humidity)% humidity ")
    }
}


//MARK:------使用Foundation中自带的通知模式
//subject
class Boss1 : NSObject{
    func sendMessage(_ message : String){
        //1、创建消息字典
        let userInfo = ["message":message]
        //2、创建通知
        let notification = Notification.init(name: Notification.Name(rawValue: "Boss1"), object: nil, userInfo: userInfo)
        //3、发送通知
        NotificationCenter.default.post(notification)
    }
}
//添加observer
class Coder1:NSObject{
    func observerBoss(){
        NotificationCenter.default.addObserver(self, selector: #selector(accepteNotification(_:)), name: NSNotification.Name(rawValue: "Boss1"), object: nil)
    }
    @objc func accepteNotification(_ notification : Notification){
        let info = notification.userInfo
        print("收到老板通知了：\(String(describing: info!["message"]))")
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Boss1"), object: nil)
    }
}


//MARK:------自定义实现通知中心
//通知
class MyCustomNotification:NSObject{
    let name : String
    let object : AnyObject?
    let userInfo : [NSObject : AnyObject]?
    
    init(_ name : String, _ object : AnyObject?, _ userInfo : [NSObject:AnyObject]?) {
        self.name = name
        self.object = object
        self.userInfo = userInfo
    }
}
//观察者
class MyObserver:NSObject{
    let observer : AnyObject
    let selector : Selector
    
    init(_ observer : AnyObject, selector : Selector){
        self.observer = observer
        self.selector = selector
    }
}
typealias ObserverArray = Array<MyObserver>
//主题
class MySubject : NSObject{
    var notification : MyCustomNotification?
    var observers : ObserverArray
    
    init(_ notification : MyCustomNotification?, _ observers : ObserverArray){
        self.notification = notification
        self.observers = observers
    }
    
    //添加观察者
    func addCustomObserver(_ observer : MyObserver){
        for i in 0..<observers.count {
            if observers[i].observer === observer.observer{
                return
            }
        }
        self.observers.append(observer)
    }
    
    //移除观察者
    func removeCustomObserver(_ observer : MyObserver){
        for i in 0..<observers.count {
            if observers[i].observer === observer.observer{
                observers.remove(at: i)
                break
            }
        }
    }
    
    //发送通知
    func postNotification(){
        for i in 0..<observers.count {
            let myObserver : MyObserver = self.observers[i]
            myObserver.observer.performSelector(inBackground: myObserver.selector, with: self.notification)
        }
    }
}
//通知中心
typealias SubjectDictionary = Dictionary<String, MySubject>
class MyCustomNotificationCenter : NSObject{
    //================创建单例=============================
    private static let singleton = MyCustomNotificationCenter()
    static func defaultCenter()->MyCustomNotificationCenter{
        return singleton
    }
    override init() {
        super.init()
    }
    
    //================通知中心，存储的是Subject对象的集合============
    private var center : SubjectDictionary = SubjectDictionary()
    
    //发出通知
    func postNotification(_ notification : MyCustomNotification){
        //首先会调用getSubjectWithNotifaction(notification)方法来从center中获取可以发送该notification的Subject对象
        let subject = self.getSubjectNotification(notification)
        //然后调用该subject对象的postNotification()方法即可
        subject.postNotification()
    }
    
    //根据notification获取相应的subject对象，没有的话就创建
    func getSubjectNotification(_ notification : MyCustomNotification)->MySubject{
        
        guard let subject = center[notification.name] else {
            //如果center中没有可以发送该notification的对象，那么就创建一个MySubject对象，并将该notification赋值给这个新建的MySubject对象，
            //最后将我们创建的这个新的subject添加进center数组中
            center[notification.name] = MySubject(notification, ObserverArray())
            return self.getSubjectNotification(notification)
        }
        if subject.notification == nil {
            subject.notification = notification
        }
        return subject
    }
    
    //添加监听者
    func addObserver(_ observer : AnyObject, _ aSelector : Selector, _ aName : String){
        //首先我们把传入的参数生成MyObserver的对象
        let myObserver = MyObserver(observer, selector: aSelector)
        //通过aName从center字典中获取相应的MySubject对象
        var subject : MySubject? = center[aName]
        
        //如果center中没有对应的MySubject对象，我们就创建该对象，并且将该对象的notification属性暂且指定为nil
        if subject == nil {
            subject = MySubject(nil, ObserverArray())
            center[aName] = subject
        }
        
        //调用MySubject类中的addCustomObserver()方法进行观察者的添加
        subject?.addCustomObserver(myObserver)
    }
    
    //从通知中心移除observer
    func removeObserver(_ observer : AnyObject, _ name : String){
        //首先也是通过name从center字典中获取MySubject的对象
        guard let subject : MySubject = center[name] else {
            return
        }
        //然后调用MySubject对象的removeCustomObserver()方法进行移除掉
        subject.removeCustomObserver(observer as! MyObserver)
    }
}

class Boss2 : NSObject{
    func sendMessage(_ message : String){
        //1、创建消息字典
        let userInfo = ["message":message]
        //2、创建通知
        let notification = MyCustomNotification.init(Notification.Name(rawValue: "Boss2").rawValue, nil, userInfo as [NSObject : AnyObject])
        //3、发送通知
        MyCustomNotificationCenter.defaultCenter().postNotification(notification)
    }
}
//添加observer
class Coder2:NSObject{
    func observerBoss(){
        MyCustomNotificationCenter.defaultCenter().addObserver(self, #selector(accepteNotification(_:)), "Boss2")
    }
    @objc func accepteNotification(_ notification : MyCustomNotification){
        let info : Dictionary = notification.userInfo!
        print("收到老板通知了:",info["message" as! NSObject])
    }
    deinit {
        MyCustomNotificationCenter.defaultCenter().removeObserver(self, "Boss2")
    }
}
