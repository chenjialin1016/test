//
//  ProjectClass.swift
//  test
//
//  Created by Jialin Chen on 2019/6/13.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

//2、需要实现 projrct 类
class Project {
    private let id : Int
    init(_ id : Int) {
        self.id = id
    }
    
    //4、编写你想要存在的方法
    func asDictionary()->[String:AnyObject]{
//        return [String:AnyObject]()
        //6、实现方法，通过测试
        //return ["id":5 as AnyObject]
        
        //7、改进方法返回
        return ["id":id as AnyObject]
    }
}
