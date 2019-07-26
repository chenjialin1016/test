//
//  Command Pattern.swift
//  test
//
//  Created by Jialin Chen on 2019/7/26.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//https://www.cnblogs.com/ludashi/p/5396571.html

import UIKit

//MARK:------”命令模式“ Command Pattern
/*
 命令模式：将“请求”封装成对象，以便使用不同的请求、队列或者日志来参数化其他对象。命令模式也支持可撤销的操作。
 简单说：将一些列的命令（函数/方法）进行封装，隐藏内部执行细节，并对外留出调用的接口
 
 对具体的实现进行了封装，并对外留出调用接口
 
 */

//自上而下实现类图
//MARK:------1、具体命令执行对象的实现

class Light{
    func on(){
        print("电灯已打开")
    }
    
    func off(){
        print("电灯已关闭")
    }
}
class Computer{
    func start(){
        print("计算机正在启动")
    }
    func screenLight(){
        print("屏幕已经点亮")
    }
    func load(){
        print("计算机正在加载系统")
    }
    func startOver(){
        print("计算机启动完毕")
    }
    func off(){
        print("计算机已关闭")
    }
}

//MARK:------2、命令集合实现
//将command声明为协议（命令对外的接口）
//命令接口
protocol Command {
    func execute()->Void
}
//打开电灯命令
class LightOnCommand:Command{
    private let light = Light()
    func execute() {
        light.on()
    }
}
//关闭电灯命令
class LightOffCommand:Command{
    private let light = Light()
    func execute() {
        light.off()
    }
}
//启动计算机命令
class ComputerStartCommand:Command{
    private let computer = Computer()
    func execute() {
        computer.start()
        computer.screenLight()
        computer.load()
        computer.startOver()
    }
}

//MARK:------3、console控制台实现
class Console{
    private var command : Command? = nil
    func setCommand(_ command : Command){
        self.command = command
    }
    func action(){
        command?.execute()
    }
}
