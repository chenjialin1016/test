//
//  SMHook.h
//  test
//
//  Created by Jialin Chen on 2019/7/15.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

/*
 运行时方法替换方式进行埋点 实现 无侵入埋点方法
 
 具体实现：先写一个先写一个运行时方法替换的类SMHook，加上替换的方法 hookClass:fromSelector:toSelector
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMHook : NSObject

+ (void)hookClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector;

@end

NS_ASSUME_NONNULL_END
