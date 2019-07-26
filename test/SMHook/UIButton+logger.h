//
//  UIButton+logger.h
//  test
//
//  Created by Jialin Chen on 2019/7/15.
//  Copyright © 2019年 Jialin Chen. All rights reserved.
//

/*
 UIButton 在视图中可能有多个不同的继承类，
 
 相同UIButton的子类在不同视图类的埋点也要区分开来，需要通过 action选择器名 + 视图类名 组成一个唯一的标识，来进行埋点记录
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (logger)

@end

NS_ASSUME_NONNULL_END
