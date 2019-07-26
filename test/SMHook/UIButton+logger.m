//
//  UIButton+logger.m
//  test
//
//  Created by Jialin Chen on 2019/7/15.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import "UIButton+logger.h"
#import "SMHook.h"

@implementation UIButton (logger)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL fromSelector = @selector(sendAction:to:forEvent:);
        SEL toSelector = @selector(hook_sendAction:to:forEvent:);
        [SMHook hookClass:self fromSelector:fromSelector toSelector:toSelector];
    });
}

- (void)hook_sendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event{
    
}
- (void)insertToSendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event{
    //日志记录
    if ([[[event allTouches] anyObject] phase] == UITouchPhaseEnded){
        NSString *actionString = NSStringFromSelector(action);
        NSString *targetName = NSStringFromClass([target class]);
//        [[[SMLogger create] message:[NSString stringWithFormat:@"%@ %@",targetName,actionString]] save];
    }
}
@end
