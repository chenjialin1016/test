//
//  DesignPatterns.swift
//  test
//
//  Created by Jialin Chen on 2019/7/1.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

func designPatternsTest(){
    print("==============策略模式==============")
    //中尉
    let lieutenant : Lieutenant = Lieutenant()
    lieutenant.fire()
    print("\n手枪火力不行，得换HK48\n")
    lieutenant.changeHK()
    lieutenant.fire()
    
    print("\n-----某些鸭子增加飞行的能力")
//    print("鸭子：使用延展")
//    let mallarDuck : MallarDuck = MallarDuck()
//    mallarDuck.fly()
    
    print("鸭子：使用接口")
    var duck : Duck = MallarDuck()
    duck.performFly()
    duck.setFlyBehavior(FlyNoWay())
    duck.performFly()
    print("-----创建一个模型鸭子，且会飞")
    duck = ModelDuck()
    duck.performFly()
    print("-----给模型鸭子装发动机，支持飞")
    duck.setFlyBehavior(FlyAutomaticPower())
    duck.performFly()
    print("\n")
    
    print("==============观察者模式==============")
    //创建boss
    let bossSubject : Boss = Boss()
    //创建观察者
    let coderObserver : Coder = Coder()
    let PMObserver : PM = PM()
    //添加观察者
    bossSubject.registerObserver(coderObserver)
    bossSubject.registerObserver(PMObserver)
    print(bossSubject.observersArray)
    bossSubject.setInfo("第一次通知")
    //程序员走出了会议室（移除通知）
    bossSubject.removeObserver(coderObserver)
    bossSubject.setInfo("第二次通知")
    print("------Foundation自带的通知模式")
    let boss1 = Boss1()
    let coder1 = Coder1()
    coder1.observerBoss()
    boss1.sendMessage("涨工资啦")
    print("------自定义的通知中心")
    let boss2 = Boss2()
    let coder2 = Coder2()
    let coder3 = Coder2()
    coder2.observerBoss()
    coder3.observerBoss()
    boss2.sendMessage("涨工资啦")
    print("------气象观测")
    let weatherData : WeatherData = WeatherData()
    let currentConditions = CurrentConditionsDisplay(weatherData)
    weatherData.setMeasurements(20, 34, 40)
    print("\n")
    
    
    print("==============装饰者模式==============")
    //创建空花瓶
    var porcelain : VaseComponent = Porcelain()
    //打印最新的描述信息
    porcelain.display()
    //插入玫瑰
    porcelain = Rose(porcelain)
    //插入百合
    porcelain = Lily(porcelain)
    //打印最新的描述信息
    porcelain.display()
    print("\n")
}
