//
//  SMCPUMonitor.h
//  test
//
//  Created by Jialin Chen on 2019/7/17.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMCPUMonitor : NSObject
+ (void)updateCPU;
//获得当前app所在进程的cpu使用率
+ (integer_t)cpuUsage;
@end

NS_ASSUME_NONNULL_END
