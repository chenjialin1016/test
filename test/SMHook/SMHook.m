//
//  SMHook.m
//  test
//
//  Created by Jialin Chen on 2019/7/15.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

#import "SMHook.h"
#import <objc/runtime.h>

@implementation SMHook

+ (void)hookClass:(Class)classObject fromSelector:(SEL)fromSelector toSelector:(SEL)toSelector{
    Class class = classObject;
    
    //得到被替换的类的实例方法
    Method fromMethod = class_getInstanceMethod(class, fromSelector);
    //得到替换类的实例方法
    Method toMethod = class_getInstanceMethod(class, toSelector);
    //class_addMethod 返回成功表示被替换的方法没实现，然后会通过 class_addMethod 方法先实现
    //返回失败则表示被替换的方法已存在，可以直接进行IMP指针交换
    if (class_addMethod(class, fromSelector, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        //进行方法替换
        class_replaceMethod(class, toSelector, method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
    }else{
        //交换 imp 指针
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

@end
