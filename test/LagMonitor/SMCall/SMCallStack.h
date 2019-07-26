//
//  SMCallStack.h
//  test
//
//  Created by Jialin Chen on 2019/7/17.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMCallLib.h"

typedef NS_ENUM(NSUInteger, SMCallStackType) {
    SMCallStackTypeAll,     //全部线程
    SMCallStackTypeMain,    //主线程
    SMCallStackTypeCurrent  //当前线程
};
NS_ASSUME_NONNULL_BEGIN

@interface SMCallStack : NSObject

+ (NSString *)callStackWithType:(SMCallStackType)type;

extern NSString *smStackOfThread(thread_t thread);

@end

NS_ASSUME_NONNULL_END
