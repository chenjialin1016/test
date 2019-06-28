//
//  TwitterConnection.swift
//  test
//
//  Created by Jialin Chen on 2019/6/19.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import Foundation


//网络连接类
@objc
protocol Connection {
    func fetchData()->String
}

@objcMembers
class TwitterConnection: NSObject, Connection{

    func fetchData() -> String {
        return "real data returned from other system"
    }
//    public func tweetWithBlock(_ block:(Dictionary<String, String>, Error?)->())->Void{
//        block(["hh":"hh"],nil)
//    }
}
