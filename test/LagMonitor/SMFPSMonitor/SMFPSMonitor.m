//
//  SMFPSMonitor.m
//  test
//
//  Created by Jialin Chen on 2019/7/22.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import "SMFPSMonitor.h"

@interface SMFPSMonitor()

@property(nonatomic, assign)CFTimeInterval lastTimeStamp;
@property(nonatomic, assign)NSInteger total;
@property(nonatomic, assign)float fps;

@end

@implementation SMFPSMonitor
- (void)start{
    self.dLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fpsCount:)];
    [self.dLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

//方法执行帧率和屏幕刷新率保持一致
- (void)fpsCount:(CADisplayLink *)displayLink{
    if (self.lastTimeStamp == 0) {
        self.lastTimeStamp = self.dLink.timestamp;
    }else{
        self.total++;
        //开始渲染时间与上次渲染时间差值
        NSTimeInterval useTime = self.dLink.timestamp - self.lastTimeStamp;
        if (useTime < 1) {
            return;
        }
        self.lastTimeStamp = self.dLink.timestamp;
        //fps 计算
        self.fps = self.total / useTime;
        self.total = 0;
    }
}


@end
