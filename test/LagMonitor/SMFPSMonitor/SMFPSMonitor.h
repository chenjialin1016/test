//
//  SMFPSMonitor.h
//  test
//
//  Created by Jialin Chen on 2019/7/22.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMFPSMonitor : NSObject

@property(nonatomic, strong)CADisplayLink *dLink;

- (void)start;
@end

NS_ASSUME_NONNULL_END
