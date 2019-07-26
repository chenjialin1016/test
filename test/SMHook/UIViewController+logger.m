//
//  UIViewController+logger.m
//  test
//
//  Created by Jialin Chen on 2019/7/15.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import "UIViewController+logger.h"
#import "SMHook.h"

@implementation UIViewController (logger)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //通过 @selector 获得被替换和替换方法的 SEL, 作为 SMHook:hookClass:fromeSelector:toSelector 的参数传入
        SEL fromSelectorAppear = @selector(viewWillAppear:);
        SEL toSelectorAppear = @selector(hook_viewWillAppear:);
        
        [SMHook hookClass:self fromSelector:fromSelectorAppear toSelector:toSelectorAppear];
        
        SEL fromSelectorDisappear = @selector(viewWillDisappear:);
        SEL toSelectorDisappear = @selector(hook_viewWillDisappear:);
        
        [SMHook hookClass:self fromSelector:fromSelectorDisappear toSelector:toSelectorDisappear];
    });
}

- (void)hook_viewWillAppear:(BOOL)animated{
    //先执行插入代码，在执行原 viewWillAppear 方法
    [self insertToViewWillAppear];
    [self hook_viewWillAppear:animated];
}
- (void)hook_viewWillDisappear:(BOOL)animated{
    //先执行插入代码，在执行原 viewWillDisappear 方法
    [self insertToViewWillDisappear];
    [self hook_viewWillDisappear:animated];
}

- (void)insertToViewWillAppear{
    //在 viewWillAppear 时进行日志的埋点
//    [[[[SMLogger create] message:[NSString stringWithFormat:@"%@ Appear",NSStringFromClass([self class])]] classify:ProjectClassifyOperation] save];
}
- (void)insertToViewWillDisappear{
    //在 viewWillAppear 时进行日志的埋点
//    [[[[SMLogger create] message:[NSString stringWithFormat:@"%@ Disappear",NSStringFromClass([self class])]]   classify:ProjectClassifyOperation] save];
}

@end
