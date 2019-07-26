//
//  SMLagMonitor.h
//  test
//
//  Created by Jialin Chen on 2019/7/17.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMLagMonitor : NSObject

+ (instancetype)shareInstance;

//开始监控卡顿
- (void)beginMonitor;

//停止监控卡顿
- (void)endMonitor;

@end

NS_ASSUME_NONNULL_END
