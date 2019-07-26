//
//  Singleton Pattern.swift
//  test
//
//  Created by Jialin Chen on 2019/7/23.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import Foundation

//MARK:------”单例模式“ Singleton Pattern
/*
 单例模式：确保一个类只有一个实例，并提供一个全局访问点
 简单说：一个类在程序运行期间只能生成一个实例
 
 */

//MARK:------1、使用GCD实现单例
//使用GCD中的dispatch_once来实现单例
//dispatch_once_t在swift3已经废弃，可使用全局变量/带立即执行闭包初始化器的全局变量/类、结构、枚举中的静态属性

//扩展DispatchQueue实现原有的功能
public extension DispatchQueue{
    private static var _onceTracker = [String]()
    
    public class func once(_ token : String, block:@noescape(Void)->Void){
        objc_sync_enter(self)
        defer{
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}
class SingletonManager{
    
    private static let onceToken = NSUUID().uuidString
    private static var staticInstance : SingletonManager? = nil
    static func sharedInstance()->SingletonManager{
        DispatchQueue.once(onceToken) {
            staticInstance = SingletonManager()
        }
        return staticInstance!
    }
    private init() {}
}


//MARK:------2、使用静态私有常量和静态方法来实现单例
class SingletonManager1{
    
    private static let staticInstance : SingletonManager1 = SingletonManager1()
    static func sharedInstance()->SingletonManager1{
        return staticInstance
    }
    private init() {}
}
