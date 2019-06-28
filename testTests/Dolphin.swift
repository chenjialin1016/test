//
//  Banana.swift
//  testTests
//
//  Created by Jialin Chen on 2019/6/20.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

public struct Click{
    
    public var isLoud = true
    public var hasHighFrequency = true
    
    public func count()->Int{
        return 1
    }
}

class Dolphin {

    public var isFriendly = true
    public var isSmart = true
    public var isHappy = false
    
    public init(){
        
    }
    public init(_ happy : Bool){
        isHappy = happy
    }
    
    public func click()->Click{
        return Click()
    }
    
    public func eat(_ food : AnyObject){
        isHappy = true
    }
}
