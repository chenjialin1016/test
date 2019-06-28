//
//  TwitterViewController.swift
//  test
//
//  Created by Jialin Chen on 2019/6/19.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import Foundation

@objcMembers
class TwitterViewController: NSObject {

    var connection: Connection
    var data: String
    
    class func newController() -> TwitterViewController {
        return TwitterViewController()
    }
    
    override init() {
        self.connection = TwitterConnection()
        self.data = ""
    }
    
    func redisplay() {
        data = connection.fetchData()
    }

}
