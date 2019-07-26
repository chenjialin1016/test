//
//  BatteryMonitor.swift
//  test
//
//  Created by Jialin Chen on 2019/7/25.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

import UIKit

class BatteryMonitor: NSObject {

    //当前电池量
    class func currentBatteryLevel()->Float{
        return UIDevice.current.batteryLevel
    }
    
    //电池状态： (Unknown, Unplugged, Charging, or Full)
    class func batteryState()->UIDeviceBatteryState{
        return UIDevice.current.batteryState
    }
    
}
