//
//  SMMemoryMonitor.h
//  test
//
//  Created by Jialin Chen on 2019/7/22.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMMemoryMonitor : NSObject
//内存使用量的监控
+ (uint64_t)memoryUsage;
@end

NS_ASSUME_NONNULL_END
